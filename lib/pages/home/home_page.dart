import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/components/loading_indicator.dart';
import 'package:labo_flutter/components/refresher_header.dart';
import 'package:labo_flutter/models/article/article.dart';
import 'package:labo_flutter/pages/article_detail/article_detail_page.dart';
import 'package:labo_flutter/pages/home/home_page_notifier.dart';
import 'package:labo_flutter/utils/app_colors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
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
      contentType: HomePageContentType.popularArticle,
    )),
    const Center(
        child: _ArticlesQuery(
      key: PageStorageKey(1),
      contentType: HomePageContentType.newArticle,
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

class _ArticlesQuery extends HookConsumerWidget {
  const _ArticlesQuery({Key? key, required this.contentType}) : super(key: key);
  final HomePageContentType contentType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _pageNotifier = ref.watch(homePageNotifierProvider(contentType));

    return _pageNotifier.articlesValue.when(
      data: (articles) {
        return SmartRefresher(
          controller: _pageNotifier.refreshController,
          header: const RefresherHeader(),
          onRefresh: () async {
            await _pageNotifier.onRefresh();
          },
          child: _buildListView(articles),
        );
      },
      loading: () {
        return const LoadingIndicator();
      },
      error: (error, stackTrace) {
        return Text('エラーが発生しました: $error');
      },
    );
  }

  ListView _buildListView(List<Article> articles) {
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
              builder: (context) => ArticleDetailPage(
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
