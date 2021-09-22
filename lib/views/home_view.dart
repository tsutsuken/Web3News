import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:labo_flutter/models/article/article.dart';
import 'package:labo_flutter/utils/app_colors.dart';
import 'package:labo_flutter/views/article_detail_view.dart';

const String queryArticlesPopular = '''
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

const String queryArticlesNew = '''
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
    const Center(
        child: _ArticlesQuery(
      key: PageStorageKey(0),
      query: queryArticlesPopular,
    )),
    const Center(
        child: _ArticlesQuery(
      key: PageStorageKey(1),
      query: queryArticlesNew,
    )),
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
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(30),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
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
  const _ArticlesQuery({Key? key, required this.query}) : super(key: key);
  final String query;

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql(query),
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
            addAutomaticKeepAlives: true,
            cacheExtent: 1000,
            itemCount: articles.length,
            itemBuilder: (BuildContext context, int index) {
              final article = articles[index];
              return _ArticleListItem(
                  key: ValueKey(index), context: context, article: article);
            });
      },
    );
  }
}

class _ArticleListItem extends StatefulWidget {
  const _ArticleListItem({
    Key? key,
    required this.context,
    required this.article,
  }) : super(key: key);

  final BuildContext context;
  final Article article;

  @override
  _ArticleListItemState createState() => _ArticleListItemState();
}

class _ArticleListItemState extends State<_ArticleListItem>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
              builder: (context) => ArticleDetailView(
                  articleId: widget.article.id,
                  articleUrl: widget.article.url)),
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
                child: CachedNetworkImage(
                  width: 160,
                  fit: BoxFit.cover,
                  imageUrl: widget.article.urlToImage,
                  errorWidget: (context, url, dynamic error) =>
                      Image.asset('assets/images/default_article.png'),
                ),
              ),
              Flexible(
                child: Text(
                  widget.article.title,
                  style: TextStyle(
                    color: AppColors().textPrimary,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
