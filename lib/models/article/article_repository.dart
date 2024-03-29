import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/graphql_api_client.dart';
import 'package:labo_flutter/models/article/article.dart';

const String popularArticlesQuery = '''
query MyQuery()
{
  articles(order_by: {created_at: desc}, limit: 50) {
    id
    published_at
    title
    url
    url_to_image
    is_favorite
  }
}
''';

const String newArticlesQuery = '''
query MyQuery()
{
  articles(order_by: {created_at: desc}, limit: 50) {
    id
    published_at
    title
    url
    url_to_image
    is_favorite
  }
}
''';

const String articlesByUrlQuery = '''
query MyQuery(\$url: String!)
{
  articles(where: {url: {_eq: \$url}}, limit: 1) {
    id
    published_at
    title
    url
    url_to_image
    is_favorite
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
  Future<Article?> fetchArticleByUrl(String url);
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

    if (result.hasException) {
      debugPrint('_fetchArticles exception: ${result.exception.toString()}');
      return articles;
    }

    final resultData = result.data;
    if (resultData != null) {
      articles = ArticleListResponse.fromJson(resultData).articles;
    }

    return articles;
  }

  @override
  Future<Article?> fetchArticleByUrl(String url) async {
    debugPrint('fetchArticleByUrl url: $url');
    final result = await _client.query(
      QueryOptions(
        document: gql(articlesByUrlQuery),
        fetchPolicy: FetchPolicy.cacheAndNetwork,
        variables: <String, dynamic>{
          'url': url,
        },
      ),
    );

    if (result.hasException) {
      debugPrint('fetchArticleByUrl exception: ${result.exception.toString()}');
      return null;
    }

    final resultData = result.data;
    if (resultData == null) {
      return null;
    }

    final articles = ArticleListResponse.fromJson(resultData).articles;
    Article? article;
    if (articles.isNotEmpty) {
      article = articles.first;
    }
    return article;
  }
}
