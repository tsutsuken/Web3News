import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/components/article_bottom_sheet.dart';
import 'package:labo_flutter/components/article_list_item.dart';
import 'package:labo_flutter/components/loading_indicator.dart';
import 'package:labo_flutter/components/refresher_footer.dart';
import 'package:labo_flutter/components/refresher_header.dart';
import 'package:labo_flutter/models/favorite/favorite.dart';
import 'package:labo_flutter/pages/article_detail/article_detail_page.dart';
import 'package:labo_flutter/pages/favorite_article_list/favorite_article_list_page_notifier.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FavoriteArticleListPage extends HookConsumerWidget {
  const FavoriteArticleListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(favoriteArticleListPageNotifierProvider);
    final favoritesValue = ref.watch(favoriteArticleListPageNotifierProvider
        .select((value) => value.favoritesValue));

    Future<void> _onTapMenuButton(
      BuildContext context,
      FavoriteArticleListPageNotifier pageNotifier,
      Favorite favorite,
    ) async {
      final article = favorite.article;
      if (article == null) {
        return;
      }

      await showArticleBottomSheet(
        context: context,
        isFavorite: true,
        onTapFavorite: () async {
          // 通信前に表示を切り替える
          pageNotifier.deleteFavoriteOnLocal(favorite);

          // 通信する
          final didSuccess =
              await pageNotifier.deleteFavoriteOnServer(favorite);

          // 通信に失敗した場合
          if (didSuccess) {
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

    return Scaffold(
      appBar: AppBar(title: const Text('お気に入りした記事')),
      body: favoritesValue.when(
        data: (favorites) {
          return SmartRefresher(
            controller: pageNotifier.refreshController,
            enablePullUp: true,
            header: const RefresherHeader(),
            footer: const RefresherFooter(),
            onRefresh: () async {
              await pageNotifier.onRefresh();
            },
            onLoading: () async {
              await pageNotifier.onLoadMore();
            },
            child: ListView.builder(
              shrinkWrap: true,
              addAutomaticKeepAlives: true,
              cacheExtent: 1000,
              itemCount: favorites.length,
              itemBuilder: (BuildContext context, int index) {
                final favorite = favorites[index];
                final article = favorite.article;
                if (article == null) {
                  return const ListTile(
                    title: Text('記事を取得出来ませんでした'),
                  );
                }
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
                          isFavorite: true,
                        ),
                        settings:
                            const RouteSettings(name: 'ArticleDetailPage'),
                      ),
                    );
                  },
                  onTapMenuButton: () async {
                    await _onTapMenuButton(context, pageNotifier, favorite);
                  },
                );
              },
            ),
          );
        },
        loading: () {
          return const LoadingIndicator();
        },
        error: (error, stackTrace) {
          return const Text('エラーが発生しました');
        },
      ),
    );
  }
}
