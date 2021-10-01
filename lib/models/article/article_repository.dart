import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/graphql_api_client.dart';
import 'package:labo_flutter/models/article/article.dart';

const String popularArticlesQuery = '''
{
  articles(order_by: {published_at: asc}, limit: 50) {
    id
    published_at
    title
    url
    url_to_image
  }
}
''';

const String newArticlesQuery = '''
{
  articles(order_by: {published_at: desc}, limit: 50) {
    id
    published_at
    title
    url
    url_to_image
  }
}
''';

const String insertArticleMutation = '''
  mutation MyMutation(\$url: String!) {
    insert_articles_one(object: {url: \$url}) {
      id
    }
  }
''';

final articleRepositoryProvider = Provider.autoDispose<ArticleRepositoryImpl>(
  (ref) {
    final graphQLClientNotifier = ref.read(graphQLClientProvider);

    return ArticleRepositoryImpl(graphQLClientNotifier.value);
  },
);

abstract class ArticleRepository {
  Future<List<Article>> fetchPopularArticles();
  Future<List<Article>> fetchNewArticles();
  Future<String?> addArticle(String url);
}

class ArticleRepositoryImpl implements ArticleRepository {
  ArticleRepositoryImpl(this._client);

  final GraphQLClient _client;

  @override
  Future<List<Article>> fetchPopularArticles() async {
    final _articles = await _fetchArticles(popularArticlesQuery);
    return _articles;
  }

  @override
  Future<List<Article>> fetchNewArticles() async {
    final _articles = await _fetchArticles(newArticlesQuery);
    return _articles;
  }

  Future<List<Article>> _fetchArticles(String query) async {
    var articles = <Article>[];
    final result = await _client.query(
      QueryOptions(
        document: gql(query),
        fetchPolicy: FetchPolicy.cacheAndNetwork,
      ),
    );

    final resultData = result.data;
    if (resultData != null) {
      articles = ArticleListResponse.fromJson(resultData).articles;
    }

    return articles;
  }

  @override
  Future<String?> addArticle(String url) async {
    Article? addedArticle;
    try {
      final result = await _client.mutate(
        MutationOptions(
          document: gql(insertArticleMutation),
          variables: <String, dynamic>{
            'url': url,
          },
        ),
      );

      final resultData = result.data;
      if (resultData != null) {
        addedArticle =
            InsertArticlesOneResponse.fromJson(resultData).insertArticlesOne;
      }
    } on Exception catch (e) {
      debugPrint('addArticle error: $e');
      return null;
    }

    return addedArticle?.id;
  }
}
