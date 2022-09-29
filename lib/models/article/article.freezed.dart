// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'article.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

InsertArticlesOneResponse _$InsertArticlesOneResponseFromJson(
    Map<String, dynamic> json) {
  return _InsertArticlesOneResponse.fromJson(json);
}

/// @nodoc
mixin _$InsertArticlesOneResponse {
  Article? get insertArticlesOne => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InsertArticlesOneResponseCopyWith<InsertArticlesOneResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InsertArticlesOneResponseCopyWith<$Res> {
  factory $InsertArticlesOneResponseCopyWith(InsertArticlesOneResponse value,
          $Res Function(InsertArticlesOneResponse) then) =
      _$InsertArticlesOneResponseCopyWithImpl<$Res>;
  $Res call({Article? insertArticlesOne});

  $ArticleCopyWith<$Res>? get insertArticlesOne;
}

/// @nodoc
class _$InsertArticlesOneResponseCopyWithImpl<$Res>
    implements $InsertArticlesOneResponseCopyWith<$Res> {
  _$InsertArticlesOneResponseCopyWithImpl(this._value, this._then);

  final InsertArticlesOneResponse _value;
  // ignore: unused_field
  final $Res Function(InsertArticlesOneResponse) _then;

  @override
  $Res call({
    Object? insertArticlesOne = freezed,
  }) {
    return _then(_value.copyWith(
      insertArticlesOne: insertArticlesOne == freezed
          ? _value.insertArticlesOne
          : insertArticlesOne // ignore: cast_nullable_to_non_nullable
              as Article?,
    ));
  }

  @override
  $ArticleCopyWith<$Res>? get insertArticlesOne {
    if (_value.insertArticlesOne == null) {
      return null;
    }

    return $ArticleCopyWith<$Res>(_value.insertArticlesOne!, (value) {
      return _then(_value.copyWith(insertArticlesOne: value));
    });
  }
}

/// @nodoc
abstract class _$$_InsertArticlesOneResponseCopyWith<$Res>
    implements $InsertArticlesOneResponseCopyWith<$Res> {
  factory _$$_InsertArticlesOneResponseCopyWith(
          _$_InsertArticlesOneResponse value,
          $Res Function(_$_InsertArticlesOneResponse) then) =
      __$$_InsertArticlesOneResponseCopyWithImpl<$Res>;
  @override
  $Res call({Article? insertArticlesOne});

  @override
  $ArticleCopyWith<$Res>? get insertArticlesOne;
}

/// @nodoc
class __$$_InsertArticlesOneResponseCopyWithImpl<$Res>
    extends _$InsertArticlesOneResponseCopyWithImpl<$Res>
    implements _$$_InsertArticlesOneResponseCopyWith<$Res> {
  __$$_InsertArticlesOneResponseCopyWithImpl(
      _$_InsertArticlesOneResponse _value,
      $Res Function(_$_InsertArticlesOneResponse) _then)
      : super(_value, (v) => _then(v as _$_InsertArticlesOneResponse));

  @override
  _$_InsertArticlesOneResponse get _value =>
      super._value as _$_InsertArticlesOneResponse;

  @override
  $Res call({
    Object? insertArticlesOne = freezed,
  }) {
    return _then(_$_InsertArticlesOneResponse(
      insertArticlesOne: insertArticlesOne == freezed
          ? _value.insertArticlesOne
          : insertArticlesOne // ignore: cast_nullable_to_non_nullable
              as Article?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_InsertArticlesOneResponse implements _InsertArticlesOneResponse {
  const _$_InsertArticlesOneResponse({this.insertArticlesOne = null});

  factory _$_InsertArticlesOneResponse.fromJson(Map<String, dynamic> json) =>
      _$$_InsertArticlesOneResponseFromJson(json);

  @override
  @JsonKey()
  final Article? insertArticlesOne;

  @override
  String toString() {
    return 'InsertArticlesOneResponse(insertArticlesOne: $insertArticlesOne)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_InsertArticlesOneResponse &&
            const DeepCollectionEquality()
                .equals(other.insertArticlesOne, insertArticlesOne));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(insertArticlesOne));

  @JsonKey(ignore: true)
  @override
  _$$_InsertArticlesOneResponseCopyWith<_$_InsertArticlesOneResponse>
      get copyWith => __$$_InsertArticlesOneResponseCopyWithImpl<
          _$_InsertArticlesOneResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_InsertArticlesOneResponseToJson(
      this,
    );
  }
}

abstract class _InsertArticlesOneResponse implements InsertArticlesOneResponse {
  const factory _InsertArticlesOneResponse({final Article? insertArticlesOne}) =
      _$_InsertArticlesOneResponse;

  factory _InsertArticlesOneResponse.fromJson(Map<String, dynamic> json) =
      _$_InsertArticlesOneResponse.fromJson;

  @override
  Article? get insertArticlesOne;
  @override
  @JsonKey(ignore: true)
  _$$_InsertArticlesOneResponseCopyWith<_$_InsertArticlesOneResponse>
      get copyWith => throw _privateConstructorUsedError;
}

ArticleListResponse _$ArticleListResponseFromJson(Map<String, dynamic> json) {
  return _ArticleListResponse.fromJson(json);
}

/// @nodoc
mixin _$ArticleListResponse {
  List<Article> get articles => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ArticleListResponseCopyWith<ArticleListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArticleListResponseCopyWith<$Res> {
  factory $ArticleListResponseCopyWith(
          ArticleListResponse value, $Res Function(ArticleListResponse) then) =
      _$ArticleListResponseCopyWithImpl<$Res>;
  $Res call({List<Article> articles});
}

/// @nodoc
class _$ArticleListResponseCopyWithImpl<$Res>
    implements $ArticleListResponseCopyWith<$Res> {
  _$ArticleListResponseCopyWithImpl(this._value, this._then);

  final ArticleListResponse _value;
  // ignore: unused_field
  final $Res Function(ArticleListResponse) _then;

  @override
  $Res call({
    Object? articles = freezed,
  }) {
    return _then(_value.copyWith(
      articles: articles == freezed
          ? _value.articles
          : articles // ignore: cast_nullable_to_non_nullable
              as List<Article>,
    ));
  }
}

/// @nodoc
abstract class _$$_ArticleListResponseCopyWith<$Res>
    implements $ArticleListResponseCopyWith<$Res> {
  factory _$$_ArticleListResponseCopyWith(_$_ArticleListResponse value,
          $Res Function(_$_ArticleListResponse) then) =
      __$$_ArticleListResponseCopyWithImpl<$Res>;
  @override
  $Res call({List<Article> articles});
}

/// @nodoc
class __$$_ArticleListResponseCopyWithImpl<$Res>
    extends _$ArticleListResponseCopyWithImpl<$Res>
    implements _$$_ArticleListResponseCopyWith<$Res> {
  __$$_ArticleListResponseCopyWithImpl(_$_ArticleListResponse _value,
      $Res Function(_$_ArticleListResponse) _then)
      : super(_value, (v) => _then(v as _$_ArticleListResponse));

  @override
  _$_ArticleListResponse get _value => super._value as _$_ArticleListResponse;

  @override
  $Res call({
    Object? articles = freezed,
  }) {
    return _then(_$_ArticleListResponse(
      articles: articles == freezed
          ? _value._articles
          : articles // ignore: cast_nullable_to_non_nullable
              as List<Article>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ArticleListResponse implements _ArticleListResponse {
  const _$_ArticleListResponse(
      {final List<Article> articles = const <Article>[]})
      : _articles = articles;

  factory _$_ArticleListResponse.fromJson(Map<String, dynamic> json) =>
      _$$_ArticleListResponseFromJson(json);

  final List<Article> _articles;
  @override
  @JsonKey()
  List<Article> get articles {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_articles);
  }

  @override
  String toString() {
    return 'ArticleListResponse(articles: $articles)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ArticleListResponse &&
            const DeepCollectionEquality().equals(other._articles, _articles));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_articles));

  @JsonKey(ignore: true)
  @override
  _$$_ArticleListResponseCopyWith<_$_ArticleListResponse> get copyWith =>
      __$$_ArticleListResponseCopyWithImpl<_$_ArticleListResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ArticleListResponseToJson(
      this,
    );
  }
}

abstract class _ArticleListResponse implements ArticleListResponse {
  const factory _ArticleListResponse({final List<Article> articles}) =
      _$_ArticleListResponse;

  factory _ArticleListResponse.fromJson(Map<String, dynamic> json) =
      _$_ArticleListResponse.fromJson;

  @override
  List<Article> get articles;
  @override
  @JsonKey(ignore: true)
  _$$_ArticleListResponseCopyWith<_$_ArticleListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return _Article.fromJson(json);
}

/// @nodoc
mixin _$Article {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get urlToImage => throw _privateConstructorUsedError;
  String get publishedAt => throw _privateConstructorUsedError;
  bool get isFavorite => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ArticleCopyWith<Article> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArticleCopyWith<$Res> {
  factory $ArticleCopyWith(Article value, $Res Function(Article) then) =
      _$ArticleCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String title,
      String url,
      String urlToImage,
      String publishedAt,
      bool isFavorite});
}

/// @nodoc
class _$ArticleCopyWithImpl<$Res> implements $ArticleCopyWith<$Res> {
  _$ArticleCopyWithImpl(this._value, this._then);

  final Article _value;
  // ignore: unused_field
  final $Res Function(Article) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? url = freezed,
    Object? urlToImage = freezed,
    Object? publishedAt = freezed,
    Object? isFavorite = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      urlToImage: urlToImage == freezed
          ? _value.urlToImage
          : urlToImage // ignore: cast_nullable_to_non_nullable
              as String,
      publishedAt: publishedAt == freezed
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as String,
      isFavorite: isFavorite == freezed
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_ArticleCopyWith<$Res> implements $ArticleCopyWith<$Res> {
  factory _$$_ArticleCopyWith(
          _$_Article value, $Res Function(_$_Article) then) =
      __$$_ArticleCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String title,
      String url,
      String urlToImage,
      String publishedAt,
      bool isFavorite});
}

/// @nodoc
class __$$_ArticleCopyWithImpl<$Res> extends _$ArticleCopyWithImpl<$Res>
    implements _$$_ArticleCopyWith<$Res> {
  __$$_ArticleCopyWithImpl(_$_Article _value, $Res Function(_$_Article) _then)
      : super(_value, (v) => _then(v as _$_Article));

  @override
  _$_Article get _value => super._value as _$_Article;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? url = freezed,
    Object? urlToImage = freezed,
    Object? publishedAt = freezed,
    Object? isFavorite = freezed,
  }) {
    return _then(_$_Article(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      urlToImage: urlToImage == freezed
          ? _value.urlToImage
          : urlToImage // ignore: cast_nullable_to_non_nullable
              as String,
      publishedAt: publishedAt == freezed
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as String,
      isFavorite: isFavorite == freezed
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_Article implements _Article {
  const _$_Article(
      {this.id = '',
      this.title = '',
      this.url = '',
      this.urlToImage = 'http://placehold.jp/150x150.png',
      this.publishedAt = '',
      this.isFavorite = false});

  factory _$_Article.fromJson(Map<String, dynamic> json) =>
      _$$_ArticleFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String url;
  @override
  @JsonKey()
  final String urlToImage;
  @override
  @JsonKey()
  final String publishedAt;
  @override
  @JsonKey()
  final bool isFavorite;

  @override
  String toString() {
    return 'Article(id: $id, title: $title, url: $url, urlToImage: $urlToImage, publishedAt: $publishedAt, isFavorite: $isFavorite)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Article &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.url, url) &&
            const DeepCollectionEquality()
                .equals(other.urlToImage, urlToImage) &&
            const DeepCollectionEquality()
                .equals(other.publishedAt, publishedAt) &&
            const DeepCollectionEquality()
                .equals(other.isFavorite, isFavorite));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(url),
      const DeepCollectionEquality().hash(urlToImage),
      const DeepCollectionEquality().hash(publishedAt),
      const DeepCollectionEquality().hash(isFavorite));

  @JsonKey(ignore: true)
  @override
  _$$_ArticleCopyWith<_$_Article> get copyWith =>
      __$$_ArticleCopyWithImpl<_$_Article>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ArticleToJson(
      this,
    );
  }
}

abstract class _Article implements Article {
  const factory _Article(
      {final String id,
      final String title,
      final String url,
      final String urlToImage,
      final String publishedAt,
      final bool isFavorite}) = _$_Article;

  factory _Article.fromJson(Map<String, dynamic> json) = _$_Article.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get url;
  @override
  String get urlToImage;
  @override
  String get publishedAt;
  @override
  bool get isFavorite;
  @override
  @JsonKey(ignore: true)
  _$$_ArticleCopyWith<_$_Article> get copyWith =>
      throw _privateConstructorUsedError;
}
