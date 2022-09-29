// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'favorite.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FavoriteListResponse _$FavoriteListResponseFromJson(Map<String, dynamic> json) {
  return _FavoriteListResponse.fromJson(json);
}

/// @nodoc
mixin _$FavoriteListResponse {
  List<Favorite> get favorites => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FavoriteListResponseCopyWith<FavoriteListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoriteListResponseCopyWith<$Res> {
  factory $FavoriteListResponseCopyWith(FavoriteListResponse value,
          $Res Function(FavoriteListResponse) then) =
      _$FavoriteListResponseCopyWithImpl<$Res>;
  $Res call({List<Favorite> favorites});
}

/// @nodoc
class _$FavoriteListResponseCopyWithImpl<$Res>
    implements $FavoriteListResponseCopyWith<$Res> {
  _$FavoriteListResponseCopyWithImpl(this._value, this._then);

  final FavoriteListResponse _value;
  // ignore: unused_field
  final $Res Function(FavoriteListResponse) _then;

  @override
  $Res call({
    Object? favorites = freezed,
  }) {
    return _then(_value.copyWith(
      favorites: favorites == freezed
          ? _value.favorites
          : favorites // ignore: cast_nullable_to_non_nullable
              as List<Favorite>,
    ));
  }
}

/// @nodoc
abstract class _$$_FavoriteListResponseCopyWith<$Res>
    implements $FavoriteListResponseCopyWith<$Res> {
  factory _$$_FavoriteListResponseCopyWith(_$_FavoriteListResponse value,
          $Res Function(_$_FavoriteListResponse) then) =
      __$$_FavoriteListResponseCopyWithImpl<$Res>;
  @override
  $Res call({List<Favorite> favorites});
}

/// @nodoc
class __$$_FavoriteListResponseCopyWithImpl<$Res>
    extends _$FavoriteListResponseCopyWithImpl<$Res>
    implements _$$_FavoriteListResponseCopyWith<$Res> {
  __$$_FavoriteListResponseCopyWithImpl(_$_FavoriteListResponse _value,
      $Res Function(_$_FavoriteListResponse) _then)
      : super(_value, (v) => _then(v as _$_FavoriteListResponse));

  @override
  _$_FavoriteListResponse get _value => super._value as _$_FavoriteListResponse;

  @override
  $Res call({
    Object? favorites = freezed,
  }) {
    return _then(_$_FavoriteListResponse(
      favorites: favorites == freezed
          ? _value._favorites
          : favorites // ignore: cast_nullable_to_non_nullable
              as List<Favorite>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FavoriteListResponse implements _FavoriteListResponse {
  const _$_FavoriteListResponse(
      {final List<Favorite> favorites = const <Favorite>[]})
      : _favorites = favorites;

  factory _$_FavoriteListResponse.fromJson(Map<String, dynamic> json) =>
      _$$_FavoriteListResponseFromJson(json);

  final List<Favorite> _favorites;
  @override
  @JsonKey()
  List<Favorite> get favorites {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_favorites);
  }

  @override
  String toString() {
    return 'FavoriteListResponse(favorites: $favorites)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FavoriteListResponse &&
            const DeepCollectionEquality()
                .equals(other._favorites, _favorites));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_favorites));

  @JsonKey(ignore: true)
  @override
  _$$_FavoriteListResponseCopyWith<_$_FavoriteListResponse> get copyWith =>
      __$$_FavoriteListResponseCopyWithImpl<_$_FavoriteListResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FavoriteListResponseToJson(
      this,
    );
  }
}

abstract class _FavoriteListResponse implements FavoriteListResponse {
  const factory _FavoriteListResponse({final List<Favorite> favorites}) =
      _$_FavoriteListResponse;

  factory _FavoriteListResponse.fromJson(Map<String, dynamic> json) =
      _$_FavoriteListResponse.fromJson;

  @override
  List<Favorite> get favorites;
  @override
  @JsonKey(ignore: true)
  _$$_FavoriteListResponseCopyWith<_$_FavoriteListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

Favorite _$FavoriteFromJson(Map<String, dynamic> json) {
  return _Favorite.fromJson(json);
}

/// @nodoc
mixin _$Favorite {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get articleId => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  Article? get article => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FavoriteCopyWith<Favorite> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoriteCopyWith<$Res> {
  factory $FavoriteCopyWith(Favorite value, $Res Function(Favorite) then) =
      _$FavoriteCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String userId,
      String articleId,
      String createdAt,
      Article? article});

  $ArticleCopyWith<$Res>? get article;
}

/// @nodoc
class _$FavoriteCopyWithImpl<$Res> implements $FavoriteCopyWith<$Res> {
  _$FavoriteCopyWithImpl(this._value, this._then);

  final Favorite _value;
  // ignore: unused_field
  final $Res Function(Favorite) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? articleId = freezed,
    Object? createdAt = freezed,
    Object? article = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      articleId: articleId == freezed
          ? _value.articleId
          : articleId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      article: article == freezed
          ? _value.article
          : article // ignore: cast_nullable_to_non_nullable
              as Article?,
    ));
  }

  @override
  $ArticleCopyWith<$Res>? get article {
    if (_value.article == null) {
      return null;
    }

    return $ArticleCopyWith<$Res>(_value.article!, (value) {
      return _then(_value.copyWith(article: value));
    });
  }
}

/// @nodoc
abstract class _$$_FavoriteCopyWith<$Res> implements $FavoriteCopyWith<$Res> {
  factory _$$_FavoriteCopyWith(
          _$_Favorite value, $Res Function(_$_Favorite) then) =
      __$$_FavoriteCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String userId,
      String articleId,
      String createdAt,
      Article? article});

  @override
  $ArticleCopyWith<$Res>? get article;
}

/// @nodoc
class __$$_FavoriteCopyWithImpl<$Res> extends _$FavoriteCopyWithImpl<$Res>
    implements _$$_FavoriteCopyWith<$Res> {
  __$$_FavoriteCopyWithImpl(
      _$_Favorite _value, $Res Function(_$_Favorite) _then)
      : super(_value, (v) => _then(v as _$_Favorite));

  @override
  _$_Favorite get _value => super._value as _$_Favorite;

  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? articleId = freezed,
    Object? createdAt = freezed,
    Object? article = freezed,
  }) {
    return _then(_$_Favorite(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      articleId: articleId == freezed
          ? _value.articleId
          : articleId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      article: article == freezed
          ? _value.article
          : article // ignore: cast_nullable_to_non_nullable
              as Article?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_Favorite implements _Favorite {
  const _$_Favorite(
      {this.id = '',
      this.userId = '',
      this.articleId = '',
      this.createdAt = '',
      this.article});

  factory _$_Favorite.fromJson(Map<String, dynamic> json) =>
      _$$_FavoriteFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String userId;
  @override
  @JsonKey()
  final String articleId;
  @override
  @JsonKey()
  final String createdAt;
  @override
  final Article? article;

  @override
  String toString() {
    return 'Favorite(id: $id, userId: $userId, articleId: $articleId, createdAt: $createdAt, article: $article)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Favorite &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality().equals(other.articleId, articleId) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.article, article));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(userId),
      const DeepCollectionEquality().hash(articleId),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(article));

  @JsonKey(ignore: true)
  @override
  _$$_FavoriteCopyWith<_$_Favorite> get copyWith =>
      __$$_FavoriteCopyWithImpl<_$_Favorite>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FavoriteToJson(
      this,
    );
  }
}

abstract class _Favorite implements Favorite {
  const factory _Favorite(
      {final String id,
      final String userId,
      final String articleId,
      final String createdAt,
      final Article? article}) = _$_Favorite;

  factory _Favorite.fromJson(Map<String, dynamic> json) = _$_Favorite.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get articleId;
  @override
  String get createdAt;
  @override
  Article? get article;
  @override
  @JsonKey(ignore: true)
  _$$_FavoriteCopyWith<_$_Favorite> get copyWith =>
      throw _privateConstructorUsedError;
}
