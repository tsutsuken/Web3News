// Mocks generated by Mockito 5.0.16 from annotations
// in labo_flutter/test/favorite_article_list_page_notifier_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;

import 'package:graphql_flutter/graphql_flutter.dart' as _i7;
import 'package:hooks_riverpod/hooks_riverpod.dart' as _i3;
import 'package:labo_flutter/models/favorite/favorite.dart' as _i5;
import 'package:labo_flutter/pages/favorite_article_list/favorite_article_list_page_notifier.dart'
    as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:pull_to_refresh/pull_to_refresh.dart' as _i2;
import 'package:state_notifier/state_notifier.dart' as _i8;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeRefreshController_0 extends _i1.Fake
    implements _i2.RefreshController {}

class _FakeAsyncValue_1<T> extends _i1.Fake implements _i3.AsyncValue<T> {}

class _FakeFavoriteArticleListPageState_2 extends _i1.Fake
    implements _i4.FavoriteArticleListPageState {}

/// A class which mocks [FavoriteArticleListPageNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockFavoriteArticleListPageNotifier extends _i1.Mock
    implements _i4.FavoriteArticleListPageNotifier {
  MockFavoriteArticleListPageNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.RefreshController get refreshController =>
      (super.noSuchMethod(Invocation.getter(#refreshController),
          returnValue: _FakeRefreshController_0()) as _i2.RefreshController);
  @override
  _i3.AsyncValue<List<_i5.Favorite>> get favoritesValue =>
      (super.noSuchMethod(Invocation.getter(#favoritesValue),
              returnValue: _FakeAsyncValue_1<List<_i5.Favorite>>())
          as _i3.AsyncValue<List<_i5.Favorite>>);
  @override
  set favoritesValue(_i3.AsyncValue<List<_i5.Favorite>>? _favoritesValue) =>
      super.noSuchMethod(Invocation.setter(#favoritesValue, _favoritesValue),
          returnValueForMissingStub: null);
  @override
  set onError(_i3.ErrorListener? _onError) =>
      super.noSuchMethod(Invocation.setter(#onError, _onError),
          returnValueForMissingStub: null);
  @override
  bool get mounted =>
      (super.noSuchMethod(Invocation.getter(#mounted), returnValue: false)
          as bool);
  @override
  _i6.Stream<_i4.FavoriteArticleListPageState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i4.FavoriteArticleListPageState>.empty())
          as _i6.Stream<_i4.FavoriteArticleListPageState>);
  @override
  _i4.FavoriteArticleListPageState get state =>
      (super.noSuchMethod(Invocation.getter(#state),
              returnValue: _FakeFavoriteArticleListPageState_2())
          as _i4.FavoriteArticleListPageState);
  @override
  set state(_i4.FavoriteArticleListPageState? value) =>
      super.noSuchMethod(Invocation.setter(#state, value),
          returnValueForMissingStub: null);
  @override
  _i4.FavoriteArticleListPageState get debugState =>
      (super.noSuchMethod(Invocation.getter(#debugState),
              returnValue: _FakeFavoriteArticleListPageState_2())
          as _i4.FavoriteArticleListPageState);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  _i6.Future<void> fetchFavorites() =>
      (super.noSuchMethod(Invocation.method(#fetchFavorites, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<void> onLoadMore() =>
      (super.noSuchMethod(Invocation.method(#onLoadMore, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  void setVariablesForLoadMore(_i7.QueryResult? result, int? lengthOfList) =>
      super.noSuchMethod(
          Invocation.method(#setVariablesForLoadMore, [result, lengthOfList]),
          returnValueForMissingStub: null);
  @override
  _i6.Future<void> onRefresh() =>
      (super.noSuchMethod(Invocation.method(#onRefresh, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  void deleteFavoriteOnLocal(_i5.Favorite? favorite) =>
      super.noSuchMethod(Invocation.method(#deleteFavoriteOnLocal, [favorite]),
          returnValueForMissingStub: null);
  @override
  _i6.Future<bool> deleteFavoriteOnServer(_i5.Favorite? favorite) => (super
      .noSuchMethod(Invocation.method(#deleteFavoriteOnServer, [favorite]),
          returnValue: Future<bool>.value(false)) as _i6.Future<bool>);
  @override
  _i3.RemoveListener addListener(
          _i8.Listener<_i4.FavoriteArticleListPageState>? listener,
          {bool? fireImmediately = true}) =>
      (super.noSuchMethod(
          Invocation.method(
              #addListener, [listener], {#fireImmediately: fireImmediately}),
          returnValue: () {}) as _i3.RemoveListener);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  String toString() => super.toString();
}
