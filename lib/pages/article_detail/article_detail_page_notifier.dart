import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/models/favorite/favorite_repository.dart';

final articleDetailPageNotifierProvider = ChangeNotifierProvider.family
    .autoDispose<ArticleDetailPageNotifier, ArticleDetailPageNotifierParams>(
  (ref, params) {
    return ArticleDetailPageNotifier(
        ref.read, params.articleUrl, params.articleId);
  },
);

class ArticleDetailPageNotifierParams {
  ArticleDetailPageNotifierParams(
      {required this.articleUrl, required this.articleId});
  final String articleUrl;
  final String? articleId;
}

class ArticleDetailPageNotifier extends ChangeNotifier {
  ArticleDetailPageNotifier(this._reader, this.articleUrl, this.articleId);

  final Reader _reader;
  final String articleUrl;
  final String? articleId;

  late final FavoriteRepository _favoriteRepository =
      _reader(favoriteRepositoryProvider);

  Future<bool> addFavorite(String? articleId) async {
    var didSuccess = false;
    if (articleId == null) {
      didSuccess = false;
    } else {
      didSuccess = await _favoriteRepository.addFavorite(articleId);
    }
    return didSuccess;
  }

  Future<bool> deleteFavorite(String id) async {
    final didSuccess = await _favoriteRepository.deleteFavorite(id);
    return didSuccess;
  }
}
