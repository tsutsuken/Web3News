import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/graphql_api_client.dart';
import 'package:labo_flutter/models/comment/comment.dart';

const String commentsFilteredOfArticleQuery = '''
query MyQuery(\$viewer_user_id: String!, \$article_id: uuid!) {
  comments_filtered(args: {viewer_user_id: \$viewer_user_id}, where: {is_banned: {_neq: true}, article_id: {_eq: \$article_id}}) {
    id
    text
    created_at
    user_id
    user {
      id
      name
      profile_image_url
    }
  }
}
''';

const String commentsOfUserQuery = '''
  query MyQuery(\$user_id: String!) {
    comments(order_by: {created_at: desc}, where: {user_id: {_eq: \$user_id}}) {
      id
      created_at
      text
      user_id
      user {
        id
        name
        profile_image_url
      }
    }
  }
''';

const String insertCommentMutation = '''
  mutation MyMutation(\$text: String!, \$article_id: uuid!) {
    insert_comments_one(object: {text: \$text, article_id: \$article_id}) {
      id
    }
  }
''';

const String deleteCommentMutation = '''
  mutation MyMutation(\$id: uuid!) {
    delete_comments_by_pk(id: \$id) {
      id
    }
  }
''';

final commentRepositoryProvider = Provider.autoDispose<CommentRepositoryImpl>(
  (ref) {
    final graphQLClientNotifier = ref.read(graphQLClientProvider);

    return CommentRepositoryImpl(graphQLClientNotifier.value);
  },
);

abstract class CommentRepository {
  Future<List<Comment>> fetchCommentsOfArticle(String articleId);
  Future<List<Comment>> fetchCommentsOfUser(String userId);
  Future<bool> addComment(String articleId, String text);
  Future<bool> deleteComment(String commentId);
}

enum CommentsOrderType {
  ascending,
  descending,
}

class CommentRepositoryImpl implements CommentRepository {
  CommentRepositoryImpl(this._client);
  final GraphQLClient _client;

  @override
  Future<List<Comment>> fetchCommentsOfArticle(String articleId) async {
    var comments = <Comment>[];
    final myUserId = FirebaseAuth.instance.currentUser?.uid ?? '';
    final result = await _client.query(
      QueryOptions(
        document: gql(commentsFilteredOfArticleQuery),
        variables: <String, dynamic>{
          'viewer_user_id': myUserId,
          'article_id': articleId,
        },
        fetchPolicy: FetchPolicy.cacheAndNetwork,
      ),
    );

    if (result.hasException) {
      debugPrint('fetchComments exception: ${result.exception.toString()}');
    }

    final resultData = result.data;
    if (resultData != null) {
      comments =
          CommentListFilteredResponse.fromJson(resultData).commentsFiltered;
    }

    return comments;
  }

  @override
  Future<List<Comment>> fetchCommentsOfUser(String userId) async {
    var comments = <Comment>[];
    final result = await _client.query(
      QueryOptions(
        document: gql(commentsOfUserQuery),
        variables: <String, dynamic>{
          'user_id': userId,
        },
        fetchPolicy: FetchPolicy.cacheAndNetwork,
      ),
    );

    final resultData = result.data;
    if (resultData != null) {
      comments = CommentListResponse.fromJson(resultData).comments;
    }

    return comments;
  }

  @override
  Future<bool> addComment(String articleId, String text) async {
    debugPrint('addComment articleId: $articleId');
    var didSuccess = false;
    try {
      final result = await _client.mutate(
        MutationOptions(
          document: gql(insertCommentMutation),
          variables: <String, dynamic>{
            'text': text,
            'article_id': articleId,
          },
        ),
      );
      if (result.hasException) {
        debugPrint('addComment exception: ${result.exception.toString()}');
      } else {
        didSuccess = true;
        debugPrint('addComment success');
      }
    } on Exception catch (e) {
      debugPrint('addComment error: $e');
    }
    return didSuccess;
  }

  @override
  Future<bool> deleteComment(String commentId) async {
    var didSuccess = false;

    final result = await _client.mutate(
      MutationOptions(
        document: gql(deleteCommentMutation),
        variables: <String, dynamic>{
          'id': commentId,
        },
      ),
    );
    if (result.hasException) {
      debugPrint('_deleteComment exception: ${result.exception.toString()}');
      didSuccess = false;
    } else {
      didSuccess = true;
    }

    return didSuccess;
  }
}
