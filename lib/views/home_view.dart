import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:labo_flutter/models/article/article.dart';
import 'package:labo_flutter/views/article_detail_view.dart';

class HomeView extends HookWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CommentsQuery()));
  }
}

class CommentsQuery extends StatelessWidget {
  const CommentsQuery({Key? key}) : super(key: key);

  static const String fetchArticlesQuery = '''
{
  articles {
    id
    publishedAt
    title
    url
    urlToImage
  }
}
''';

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql(fetchArticlesQuery),
        pollInterval: const Duration(seconds: 10),
      ),
      builder: (QueryResult result,
          {VoidCallback? refetch, FetchMore? fetchMore}) {
        if (result.hasException) {
          return Text(result.exception.toString());
        }

        if (result.isLoading) {
          return const Text('Loading');
        }

        // final articles = result.data?['articles'] as List<dynamic>;

        var articles = <Article>[];
        final resultData = result.data;
        if (resultData != null) {
          articles = ArticleListResponse.fromJson(resultData).articles;
        }

        return ListView.builder(
            shrinkWrap: true,
            itemCount: articles.length,
            itemBuilder: (BuildContext context, int index) {
              final article = articles[index];
              return _articleListItem(context, article);
            });
      },
    );
  }

  Widget _articleListItem(BuildContext context, Article article) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
              builder: (context) => ArticleDetailView(articleUrl: article.url)),
        );
      },
      child: Container(
          height: 120,
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(width: 1, color: Colors.grey))),
          child: Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 8),
                child: Image.network(
                  article.urlToImage,
                  fit: BoxFit.cover,
                  width: 160,
                ),
              ),
              Flexible(
                child: Text(
                  article.title,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ],
          )),
    );
  }
}
