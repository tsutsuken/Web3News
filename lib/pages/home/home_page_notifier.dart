import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/models/article/article.dart';
import 'package:labo_flutter/models/article/article_repository.dart';
import 'package:labo_flutter/models/favorite/favorite_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

final homePageNotifierProvider = ChangeNotifierProvider.family
    .autoDispose<HomePageNotifier, HomePageContentType>((ref, contentType) {
  return HomePageNotifier(ref.read, contentType);
});

enum HomePageContentType {
  popularArticle,
  newArticle,
}

class HomePageNotifier extends ChangeNotifier {
  HomePageNotifier(this._reader, this.contentType) {
    fetchArticles();
  }

  final Reader _reader;
  final HomePageContentType contentType;

  late final ArticleRepository _articleRepository =
      _reader(articleRepositoryProvider);
  late final FavoriteRepository _favoriteRepository =
      _reader(favoriteRepositoryProvider);
  AsyncValue<List<Article>> articlesValue = const AsyncValue.loading();
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
    articlesValue = AsyncValue.data(_articles);
    notifyListeners();
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
    final articles = articlesValue.value;
    if (articles == null) {
      return;
    }

    final newArticles = [...articles];
    final updatedArticle = article.copyWith(isFavorite: shouldFavorite);
    newArticles[
            articles.indexWhere((element) => element.id == updatedArticle.id)] =
        updatedArticle;
    articlesValue = AsyncValue.data(newArticles);
    notifyListeners();
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
