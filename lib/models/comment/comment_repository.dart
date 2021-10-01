import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/graphql_api_client.dart';
import 'package:labo_flutter/models/comment/comment.dart';

const String commentsQuery = '''
  query MyQuery(\$article_id: String!) {
    comments(where: {article_id: {_eq: \$article_id}}) {
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

const String myCommentsDescendingQuery = '''
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

const String myCommentsAscendingQuery = '''
  query MyQuery(\$user_id: String!) {
    comments(order_by: {created_at: asc}, where: {user_id: {_eq: \$user_id}}) {
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
  Future<List<Comment>> fetchComments(String articleId);
  Future<List<Comment>> fetchCommentsOfUser(
    String userId,
    CommentsOrderType orderType,
  );
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
  Future<List<Comment>> fetchComments(String articleId) async {
    var comments = <Comment>[];
    final result = await _client.query(
      QueryOptions(
        document: gql(commentsQuery),
        variables: <String, dynamic>{
          'article_id': articleId,
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
  Future<List<Comment>> fetchCommentsOfUser(
    String userId,
    CommentsOrderType orderType,
  ) async {
    var comments = <Comment>[];
    final query = (orderType == CommentsOrderType.ascending)
        ? myCommentsAscendingQuery
        : myCommentsDescendingQuery;
    final result = await _client.query(
      QueryOptions(
        document: gql(query),
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
