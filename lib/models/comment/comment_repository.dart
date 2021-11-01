import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/graphql_api_client.dart';

const String commentsFilteredOfArticleQuery = '''
query MyQuery(\$limit: Int!, \$offset: Int!, \$article_id: uuid!) {
  comments_filtered(limit: \$limit, offset: \$offset, where: {is_banned: {_neq: true}, article_id: {_eq: \$article_id}, user: {is_deleted: {_neq: true}}}) {
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
  query MyQuery(\$limit: Int!, \$offset: Int!, \$user_id: String!) {
    comments(limit: \$limit, offset: \$offset, order_by: {created_at: desc}, where: {user_id: {_eq: \$user_id}}) {
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
  Future<QueryResult> fetchCommentsOfArticle({
    required String articleId,
    int limit = 20,
  });
  Future<QueryResult> fetchMoreCommentsOfArticle({
    required String articleId,
    int limit = 20,
    int offset = 0,
    required QueryResult previousResult,
  });
  Future<QueryResult> fetchCommentsOfUser({
    required String userId,
    int limit = 20,
  });
  Future<QueryResult> fetchMoreCommentsOfUser({
    required String userId,
    int limit = 20,
    int offset = 0,
    required QueryResult previousResult,
  });
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
  Future<QueryResult> fetchCommentsOfArticle({
    required String articleId,
    int limit = 20,
  }) async {
    final result = await _client.query(
      _queryOptionsFetchCommentsOfArticle(articleId: articleId, limit: limit),
    );
    return result;
  }

  @override
  Future<QueryResult> fetchMoreCommentsOfArticle({
    required String articleId,
    int limit = 20,
    int offset = 0,
    required QueryResult previousResult,
  }) async {
    debugPrint('fetchMoreCommentsOfArticle articleId: $articleId');
    final originalQueryOptions =
        _queryOptionsFetchCommentsOfArticle(articleId: articleId, limit: limit);
    final result = await _client.fetchMore(
      FetchMoreOptions(
        variables: _queryVariablesFetchCommentsOfArticle(
          articleId: articleId,
          limit: limit,
          offset: offset,
        ),
        updateQuery: (previousResultData, fetchMoreResultData) {
          final totalFetchedComments = <dynamic>[
            ...previousResultData?['comments_filtered'] as List<dynamic>,
            ...fetchMoreResultData?['comments_filtered'] as List<dynamic>
          ];
          fetchMoreResultData?['comments_filtered'] = totalFetchedComments;

          return fetchMoreResultData;
        },
      ),
      originalOptions: originalQueryOptions,
      previousResult: previousResult,
    );
    return result;
  }

  QueryOptions _queryOptionsFetchCommentsOfArticle({
    required String articleId,
    required int limit,
  }) {
    return QueryOptions(
      document: gql(commentsFilteredOfArticleQuery),
      variables: _queryVariablesFetchCommentsOfArticle(
        articleId: articleId,
        limit: limit,
        offset: 0,
      ),
      fetchPolicy: FetchPolicy.cacheAndNetwork,
    );
  }

  Map<String, dynamic> _queryVariablesFetchCommentsOfArticle({
    required String articleId,
    required int limit,
    required int offset,
  }) {
    return <String, dynamic>{
      'article_id': articleId,
      'limit': limit,
      'offset': offset,
    };
  }

  @override
  Future<QueryResult> fetchCommentsOfUser({
    required String userId,
    int limit = 20,
  }) async {
    final result = await _client.query(
      _queryOptionsFetchCommentsOfUser(userId: userId, limit: limit),
    );
    return result;
  }

  @override
  Future<QueryResult> fetchMoreCommentsOfUser({
    required String userId,
    int limit = 20,
    int offset = 0,
    required QueryResult previousResult,
  }) async {
    debugPrint('fetchMoreCommentsOfUser userId: $userId');
    final originalQueryOptions =
        _queryOptionsFetchCommentsOfUser(userId: userId, limit: limit);
    final result = await _client.fetchMore(
      FetchMoreOptions(
        variables: _queryVariablesFetchCommentsOfUser(
            userId: userId, limit: limit, offset: offset),
        updateQuery: (previousResultData, fetchMoreResultData) {
          final totalFetchedComments = <dynamic>[
            ...previousResultData?['comments'] as List<dynamic>,
            ...fetchMoreResultData?['comments'] as List<dynamic>
          ];
          fetchMoreResultData?['comments'] = totalFetchedComments;

          return fetchMoreResultData;
        },
      ),
      originalOptions: originalQueryOptions,
      previousResult: previousResult,
    );

    return result;
  }

  QueryOptions _queryOptionsFetchCommentsOfUser({
    required String userId,
    required int limit,
  }) {
    return QueryOptions(
      document: gql(commentsOfUserQuery),
      variables: _queryVariablesFetchCommentsOfUser(
          userId: userId, limit: limit, offset: 0),
      fetchPolicy: FetchPolicy.cacheAndNetwork,
    );
  }

  Map<String, dynamic> _queryVariablesFetchCommentsOfUser({
    required String userId,
    required int limit,
    required int offset,
  }) {
    return <String, dynamic>{
      'user_id': userId,
      'limit': limit,
      'offset': offset,
    };
  }

  @override
  Future<bool> addComment(String articleId, String text) async {
    debugPrint('addComment articleId: $articleId');
    var didSuccess = false;

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
