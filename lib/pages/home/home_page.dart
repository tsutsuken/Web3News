import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/components/article_bottom_sheet.dart';
import 'package:labo_flutter/components/article_list_item.dart';
import 'package:labo_flutter/components/loading_indicator.dart';
import 'package:labo_flutter/components/refresher_header.dart';
import 'package:labo_flutter/models/article/article.dart';
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
        child: _ArticleList(
      key: PageStorageKey(0),
      contentType: HomePageContentType.popularArticle,
    )),
    const Center(
        child: _ArticleList(
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

class _ArticleList extends HookConsumerWidget {
  const _ArticleList({Key? key, required this.contentType}) : super(key: key);
  final HomePageContentType contentType;

  Future<void> _onTapMenuButton(
    BuildContext context,
    HomePageNotifier pageNotifier,
    Article article,
  ) async {
    await showArticleBottomSheet(
      context: context,
      isFavorite: article.isFavorite,
      onTapFavorite: () async {
        final shouldFavorite = !article.isFavorite;

        // 通信前に表示を切り替える
        pageNotifier.updateFavoriteOfArticleOnLocal(
            article: article, shouldFavorite: shouldFavorite);

        // 通信する
        final didSuccess = await pageNotifier.updateFavoriteOfArticleOnServer(
          article: article,
          shouldFavorite: shouldFavorite,
        );

        // 通信に失敗した場合
        if (!didSuccess) {
          // ローカルの変更を元に戻す
          pageNotifier.updateFavoriteOfArticleOnLocal(
              article: article, shouldFavorite: !shouldFavorite);
          // 通知する
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('エラーが発生しました'),
            ),
          );
        }
      },
    );
  }

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
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => ArticleDetailPage(
                        articleId: article.id,
                        articleUrl: article.url,
                        isFavorite: article.isFavorite,
                      ),
                    ),
                  );
                },
                onTapMenuButton: () async {
                  await _onTapMenuButton(context, _pageNotifier, article);
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
        return Text('エラーが発生しました');
      },
    );
  }
}
