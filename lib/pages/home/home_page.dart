import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/components/article_list_item.dart';
import 'package:labo_flutter/components/loading_indicator.dart';
import 'package:labo_flutter/components/refresher_header.dart';
import 'package:labo_flutter/pages/article_detail/article_detail_page.dart';
import 'package:labo_flutter/pages/home/home_page_notifier.dart';
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
          child: ListView.builder(
            shrinkWrap: true,
            addAutomaticKeepAlives: true,
            cacheExtent: 1000,
            itemCount: articles.length,
            itemBuilder: (BuildContext context, int index) {
              final article = articles[index];
              return ArticleListItem(
                key: ValueKey(index),
                context: context,
                article: article,
                onTap: () {
                  final isFavorite = article.favorites.isNotEmpty;
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => ArticleDetailPage(
                        articleId: article.id,
                        articleUrl: article.url,
                        isFavorite: isFavorite,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
      loading: (_) {
        return const LoadingIndicator();
      },
      error: (error, stackTrace, _) {
        return Text('エラーが発生しました: $error');
      },
    );
  }
}
