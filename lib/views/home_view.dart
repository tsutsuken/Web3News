import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:labo_flutter/models/article/article.dart';
import 'package:labo_flutter/views/article_detail_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static const List<Tab> tabs = <Tab>[
    Tab(text: '人気'),
    Tab(text: '新着'),
  ];

  final List<Widget> childViews = [
    const Center(child: _ArticlesQuery()),
    const Center(child: _ArticlesQuery()),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LaboFlutter'),
        backgroundColor: Colors.blue,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(30),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              unselectedLabelColor: Colors.white.withOpacity(0.3),
              indicatorColor: Colors.white,
              tabs: tabs,
            )),
      ),
      body: TabBarView(
        controller: _tabController,
        children: childViews,
      ),
    );
  }
}

class _ArticlesQuery extends StatelessWidget {
  const _ArticlesQuery({Key? key}) : super(key: key);

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
              builder: (context) => ArticleDetailView(
                  articleId: article.id, articleUrl: article.url)),
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
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      );
                    }
                  },
                  errorBuilder: (context, object, stack) {
                    return Image.asset('assets/images/default_article.png');
                  },
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
