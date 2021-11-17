import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/models/favorite/favorite.dart';
import 'package:labo_flutter/models/favorite/favorite_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'favorite_article_list_page_notifier.freezed.dart';

final favoriteArticleListPageNotifierProvider = StateNotifierProvider
    .autoDispose<FavoriteArticleListPageNotifier, FavoriteArticleListPageState>(
  (ref) {
    return FavoriteArticleListPageNotifier(ref.read);
  },
);

@freezed
abstract class FavoriteArticleListPageState
    with _$FavoriteArticleListPageState {
  const factory FavoriteArticleListPageState({
    @Default(AsyncValue<List<Favorite>>.loading())
        AsyncValue<List<Favorite>> favoritesValue,
  }) = _FavoriteArticleListPageState;
}

class FavoriteArticleListPageNotifier
    extends StateNotifier<FavoriteArticleListPageState> {
  FavoriteArticleListPageNotifier(this._reader)
      : super(const FavoriteArticleListPageState()) {
    fetchFavorites();
  }

  final Reader _reader;

  late final _favoriteRepository = _reader(favoriteRepositoryProvider);
  final RefreshController refreshController = RefreshController();
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
      state = state.copyWith(
        favoritesValue: AsyncValue.error(exception),
      );
      return;
    }

    var favorites = <Favorite>[];
    final resultData = result.data;
    if (resultData != null) {
      favorites = FavoriteListResponse.fromJson(resultData).favorites;
    }
    state = state.copyWith(
      favoritesValue: AsyncValue.data(favorites),
    );
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
      state = state.copyWith(
        favoritesValue: AsyncValue.error(exception),
      );
      refreshController.loadComplete();
      return;
    }

    var favorites = <Favorite>[];
    final resultData = result.data;
    if (resultData != null) {
      favorites = FavoriteListResponse.fromJson(resultData).favorites;
    }
    state = state.copyWith(
      favoritesValue: AsyncValue.data(favorites),
    );
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
    final favorites = state.favoritesValue.value;
    if (favorites == null) {
      return;
    }
    final newFavorites = [...favorites]..remove(favorite);
    state = state.copyWith(
      favoritesValue: AsyncValue.data(newFavorites),
    );
  }

  Future<bool> deleteFavoriteOnServer(Favorite favorite) async {
    final didSuccess =
        await _favoriteRepository.deleteFavorite(favorite.articleId);
    return didSuccess;
  }
}
