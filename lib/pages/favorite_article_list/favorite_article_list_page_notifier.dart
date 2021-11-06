import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/models/favorite/favorite.dart';
import 'package:labo_flutter/models/favorite/favorite_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

final favoriteArticleListPageNotifierProvider =
    ChangeNotifierProvider.autoDispose(
  (ref) {
    return FavoriteArticleListPageNotifier(ref.read);
  },
);

class FavoriteArticleListPageNotifier extends ChangeNotifier {
  FavoriteArticleListPageNotifier(this._reader) {
    fetchFavorites();
  }

  final Reader _reader;

  late final _favoriteRepository = _reader(favoriteRepositoryProvider);
  final RefreshController refreshController = RefreshController();
  AsyncValue<List<Favorite>> favoritesValue = const AsyncValue.loading();
  final int _limitFetchFavorites = 20;
  int _offsetFetchFavorites = 0;
  late QueryResult? _previousResultFetchFavorites;

  Future<void> fetchFavorites() async {
    debugPrint('fetchFavorites');
    final result =
        await _favoriteRepository.fetchMyFavorites(limit: _limitFetchFavorites);

    if (result.hasException) {
      final exception = result.exception.toString();
      debugPrint('fetchFavorites exception: $exception');
      favoritesValue = AsyncValue.error(exception);
      notifyListeners();
      return;
    }

    var favorites = <Favorite>[];
    final resultData = result.data;
    if (resultData != null) {
      favorites = FavoriteListResponse.fromJson(resultData).favorites;
    }
    favoritesValue = AsyncValue.data(favorites);
    notifyListeners();
    setVariablesForLoadMore(result, favorites.length);
  }

  Future<void> onLoadMore() async {
    debugPrint('onLoadMore');

    final result = await _favoriteRepository.fetchMoreMyFavorites(
      limit: _limitFetchFavorites,
      offset: _offsetFetchFavorites,
      previousResult: _previousResultFetchFavorites!,
    );

    if (result.hasException) {
      final exception = result.exception.toString();
      debugPrint('onLoadMore exception: $exception');
      favoritesValue = AsyncValue.error(exception);
      notifyListeners();
      refreshController.loadComplete();
      return;
    }

    var favorites = <Favorite>[];
    final resultData = result.data;
    if (resultData != null) {
      favorites = FavoriteListResponse.fromJson(resultData).favorites;
    }
    favoritesValue = AsyncValue.data(favorites);
    notifyListeners();
    setVariablesForLoadMore(result, favorites.length);
    refreshController.loadComplete();
  }

  void setVariablesForLoadMore(QueryResult result, int lengthOfList) {
    _previousResultFetchFavorites = result;
    _offsetFetchFavorites = lengthOfList;
  }

  Future<void> onRefresh() async {
    await fetchFavorites();
    refreshController.refreshCompleted();
  }

  void deleteFavoriteOnLocal(Favorite favorite) {
    debugPrint('deleteFavoriteOnLocal favorite: $favorite');
    favoritesValue.value?.remove(favorite);
    notifyListeners();
  }

  Future<bool> deleteFavoriteOnServer(Favorite favorite) async {
    final didSuccess =
        await _favoriteRepository.deleteFavorite(favorite.articleId);
    return didSuccess;
  }
}
