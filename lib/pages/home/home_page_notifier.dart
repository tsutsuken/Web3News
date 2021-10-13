import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/models/article/article.dart';
import 'package:labo_flutter/models/article/article_repository.dart';
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
  AsyncValue<List<Article>> articlesValue = const AsyncValue.loading();
  final RefreshController refreshController = RefreshController();

  Future<void> fetchArticles() async {
    var _articles = <Article>[];
    try {
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
    } on Exception catch (e) {
      debugPrint('fetchArticles error: $e');
      articlesValue = AsyncValue.error(e);
      notifyListeners();
    }
  }

  Future<void> onRefresh() async {
    await fetchArticles();
    refreshController.refreshCompleted();
  }
}
