import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/models/article/article_repository.dart';
import 'package:labo_flutter/models/favorite/favorite_repository.dart';

final articleDetailPageNotifierProvider = ChangeNotifierProvider.family
    .autoDispose<ArticleDetailPageNotifier, ArticleDetailPageNotifierParams>(
  (ref, params) {
    return ArticleDetailPageNotifier(
      reader: ref.read,
      articleUrl: params.articleUrl,
      articleId: params.articleId,
      isFavorite: params.isFavorite,
    );
  },
);

class ArticleDetailPageNotifierParams {
  ArticleDetailPageNotifierParams({
    required this.articleUrl,
    required this.articleId,
    required this.isFavorite,
  });
  final String articleUrl;
  final String? articleId;
  final bool isFavorite;
}

class ResponseOnPushFavoriteButton {
  const ResponseOnPushFavoriteButton(
      {required this.didSuccess, required this.articleId});
  final bool didSuccess;
  final String? articleId;
}

class ArticleDetailPageNotifier extends ChangeNotifier {
  ArticleDetailPageNotifier({
    required this.reader,
    required this.articleUrl,
    required this.articleId,
    required this.isFavorite,
  });

  final Reader reader;
  final String articleUrl;
  final String? articleId;
  bool isFavorite;

  late final FavoriteRepository _favoriteRepository =
      reader(favoriteRepositoryProvider);
  late final ArticleRepository _articleRepository =
      reader(articleRepositoryProvider);

  Future<ResponseOnPushFavoriteButton> onPushFavoriteButton() async {
    debugPrint('onPushFavoriteButton');
    // articleIdがnullの場合、articleをデータベースに追加する
    String? targetArticleId;
    if (articleId == null) {
      // 追加に失敗した場合、nullが返ってくる
      final addedArticleId = await _addArticle(articleUrl);
      targetArticleId = addedArticleId;
    } else {
      targetArticleId = articleId;
    }
    if (targetArticleId == null) {
      return const ResponseOnPushFavoriteButton(
        didSuccess: false,
        articleId: null,
      );
    }

    var didSuccess = false;
    if (isFavorite) {
      didSuccess = await _deleteFavorite(targetArticleId);
    } else {
      didSuccess = await _addFavorite(targetArticleId);
    }
    // isFavorite、articleIdの更新はpageで行う
    return ResponseOnPushFavoriteButton(
      didSuccess: didSuccess,
      articleId: targetArticleId,
    );
  }

  Future<String?> _addArticle(String url) async {
    final addedArticleId = await _articleRepository.addArticle(url);
    return addedArticleId;
  }

  Future<bool> _addFavorite(String targetArticleId) async {
    var didSuccess = false;
    didSuccess = await _favoriteRepository.addFavorite(targetArticleId);
    return didSuccess;
  }

  Future<bool> _deleteFavorite(String targetArticleId) async {
    var didSuccess = false;
    didSuccess = await _favoriteRepository.deleteFavorite(targetArticleId);
    return didSuccess;
  }
}
