import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/models/article/article.dart';
import 'package:labo_flutter/models/article/article_repository.dart';
import 'package:labo_flutter/models/favorite/favorite_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'home_page_notifier.freezed.dart';

final homePageNotifierProvider = StateNotifierProvider.family
    .autoDispose<HomePageNotifier, HomePageState, HomePageContentType>(
        (ref, contentType) {
  return HomePageNotifier(ref.read, contentType);
});

enum HomePageContentType {
  popularArticle,
  newArticle,
}

@freezed
abstract class HomePageState with _$HomePageState {
  const factory HomePageState({
    @Default(AsyncValue<List<Article>>.loading())
        AsyncValue<List<Article>> articlesValue,
  }) = _HomePageState;
}

class HomePageNotifier extends StateNotifier<HomePageState> {
  HomePageNotifier(this._reader, this.contentType)
      : super(const HomePageState()) {
    fetchArticles();
  }

  final Reader _reader;
  final HomePageContentType contentType;

  late final ArticleRepository _articleRepository =
      _reader(articleRepositoryProvider);
  late final FavoriteRepository _favoriteRepository =
      _reader(favoriteRepositoryProvider);
  final RefreshController refreshController = RefreshController();

  Future<void> fetchArticles() async {
    var _articles = <Article>[];
    switch (contentType) {
      case HomePageContentType.popularArticle:
        _articles = await _articleRepository.fetchPopularArticles();
        break;
      case HomePageContentType.newArticle:
        _articles = await _articleRepository.fetchNewArticles();
        break;
    }
    state = state.copyWith(
      articlesValue: AsyncValue.data(_articles),
    );
  }

  Future<void> onRefresh() async {
    await fetchArticles();
    refreshController.refreshCompleted();
  }

  void updateFavoriteOfArticleOnLocal({
    required Article article,
    required bool shouldFavorite,
  }) {
    debugPrint('updateFavoriteOfArticleOnLocal article: $article, '
        'shouldFavorite: $shouldFavorite');
    final articles = state.articlesValue.value;
    if (articles == null) {
      return;
    }

    final newArticles = [...articles];
    final updatedArticle = article.copyWith(isFavorite: shouldFavorite);
    newArticles[
            articles.indexWhere((element) => element.id == updatedArticle.id)] =
        updatedArticle;
    state = state.copyWith(
      articlesValue: AsyncValue.data(newArticles),
    );
  }

  Future<bool> updateFavoriteOfArticleOnServer({
    required Article article,
    required bool shouldFavorite,
  }) async {
    debugPrint('updateFavoriteOfArticleOnServer article: $article, '
        'shouldFavorite: $shouldFavorite');
    var didSuccess = false;
    if (shouldFavorite) {
      didSuccess = await _addFavorite(article.id);
    } else {
      didSuccess = await _deleteFavorite(article.id);
    }
    return didSuccess;
  }

  Future<bool> _addFavorite(String targetArticleId) async {
    final didSuccess = await _favoriteRepository.addFavorite(targetArticleId);
    return didSuccess;
  }

  Future<bool> _deleteFavorite(String targetArticleId) async {
    final didSuccess =
        await _favoriteRepository.deleteFavorite(targetArticleId);
    return didSuccess;
  }
}
