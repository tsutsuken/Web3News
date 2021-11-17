// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'favorite_article_list_page_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$FavoriteArticleListPageStateTearOff {
  const _$FavoriteArticleListPageStateTearOff();

  _FavoriteArticleListPageState call(
      {AsyncValue<List<Favorite>> favoritesValue =
          const AsyncValue<List<Favorite>>.loading()}) {
    return _FavoriteArticleListPageState(
      favoritesValue: favoritesValue,
    );
  }
}

/// @nodoc
const $FavoriteArticleListPageState = _$FavoriteArticleListPageStateTearOff();

/// @nodoc
mixin _$FavoriteArticleListPageState {
  AsyncValue<List<Favorite>> get favoritesValue =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FavoriteArticleListPageStateCopyWith<FavoriteArticleListPageState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoriteArticleListPageStateCopyWith<$Res> {
  factory $FavoriteArticleListPageStateCopyWith(
          FavoriteArticleListPageState value,
          $Res Function(FavoriteArticleListPageState) then) =
      _$FavoriteArticleListPageStateCopyWithImpl<$Res>;
  $Res call({AsyncValue<List<Favorite>> favoritesValue});
}

/// @nodoc
class _$FavoriteArticleListPageStateCopyWithImpl<$Res>
    implements $FavoriteArticleListPageStateCopyWith<$Res> {
  _$FavoriteArticleListPageStateCopyWithImpl(this._value, this._then);

  final FavoriteArticleListPageState _value;
  // ignore: unused_field
  final $Res Function(FavoriteArticleListPageState) _then;

  @override
  $Res call({
    Object? favoritesValue = freezed,
  }) {
    return _then(_value.copyWith(
      favoritesValue: favoritesValue == freezed
          ? _value.favoritesValue
          : favoritesValue // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<Favorite>>,
    ));
  }
}

/// @nodoc
abstract class _$FavoriteArticleListPageStateCopyWith<$Res>
    implements $FavoriteArticleListPageStateCopyWith<$Res> {
  factory _$FavoriteArticleListPageStateCopyWith(
          _FavoriteArticleListPageState value,
          $Res Function(_FavoriteArticleListPageState) then) =
      __$FavoriteArticleListPageStateCopyWithImpl<$Res>;
  @override
  $Res call({AsyncValue<List<Favorite>> favoritesValue});
}

/// @nodoc
class __$FavoriteArticleListPageStateCopyWithImpl<$Res>
    extends _$FavoriteArticleListPageStateCopyWithImpl<$Res>
    implements _$FavoriteArticleListPageStateCopyWith<$Res> {
  __$FavoriteArticleListPageStateCopyWithImpl(
      _FavoriteArticleListPageState _value,
      $Res Function(_FavoriteArticleListPageState) _then)
      : super(_value, (v) => _then(v as _FavoriteArticleListPageState));

  @override
  _FavoriteArticleListPageState get _value =>
      super._value as _FavoriteArticleListPageState;

  @override
  $Res call({
    Object? favoritesValue = freezed,
  }) {
    return _then(_FavoriteArticleListPageState(
      favoritesValue: favoritesValue == freezed
          ? _value.favoritesValue
          : favoritesValue // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<Favorite>>,
    ));
  }
}

/// @nodoc

class _$_FavoriteArticleListPageState
    with DiagnosticableTreeMixin
    implements _FavoriteArticleListPageState {
  const _$_FavoriteArticleListPageState(
      {this.favoritesValue = const AsyncValue<List<Favorite>>.loading()});

  @JsonKey(defaultValue: const AsyncValue<List<Favorite>>.loading())
  @override
  final AsyncValue<List<Favorite>> favoritesValue;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FavoriteArticleListPageState(favoritesValue: $favoritesValue)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FavoriteArticleListPageState'))
      ..add(DiagnosticsProperty('favoritesValue', favoritesValue));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FavoriteArticleListPageState &&
            (identical(other.favoritesValue, favoritesValue) ||
                other.favoritesValue == favoritesValue));
  }

  @override
  int get hashCode => Object.hash(runtimeType, favoritesValue);

  @JsonKey(ignore: true)
  @override
  _$FavoriteArticleListPageStateCopyWith<_FavoriteArticleListPageState>
      get copyWith => __$FavoriteArticleListPageStateCopyWithImpl<
          _FavoriteArticleListPageState>(this, _$identity);
}

abstract class _FavoriteArticleListPageState
    implements FavoriteArticleListPageState {
  const factory _FavoriteArticleListPageState(
          {AsyncValue<List<Favorite>> favoritesValue}) =
      _$_FavoriteArticleListPageState;

  @override
  AsyncValue<List<Favorite>> get favoritesValue;
  @override
  @JsonKey(ignore: true)
  _$FavoriteArticleListPageStateCopyWith<_FavoriteArticleListPageState>
      get copyWith => throw _privateConstructorUsedError;
}
