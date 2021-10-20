// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'article.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

InsertArticlesOneResponse _$InsertArticlesOneResponseFromJson(
    Map<String, dynamic> json) {
  return _InsertArticlesOneResponse.fromJson(json);
}

/// @nodoc
class _$InsertArticlesOneResponseTearOff {
  const _$InsertArticlesOneResponseTearOff();

  _InsertArticlesOneResponse call({Article? insertArticlesOne = null}) {
    return _InsertArticlesOneResponse(
      insertArticlesOne: insertArticlesOne,
    );
  }

  InsertArticlesOneResponse fromJson(Map<String, Object> json) {
    return InsertArticlesOneResponse.fromJson(json);
  }
}

/// @nodoc
const $InsertArticlesOneResponse = _$InsertArticlesOneResponseTearOff();

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
abstract class _$InsertArticlesOneResponseCopyWith<$Res>
    implements $InsertArticlesOneResponseCopyWith<$Res> {
  factory _$InsertArticlesOneResponseCopyWith(_InsertArticlesOneResponse value,
          $Res Function(_InsertArticlesOneResponse) then) =
      __$InsertArticlesOneResponseCopyWithImpl<$Res>;
  @override
  $Res call({Article? insertArticlesOne});

  @override
  $ArticleCopyWith<$Res>? get insertArticlesOne;
}

/// @nodoc
class __$InsertArticlesOneResponseCopyWithImpl<$Res>
    extends _$InsertArticlesOneResponseCopyWithImpl<$Res>
    implements _$InsertArticlesOneResponseCopyWith<$Res> {
  __$InsertArticlesOneResponseCopyWithImpl(_InsertArticlesOneResponse _value,
      $Res Function(_InsertArticlesOneResponse) _then)
      : super(_value, (v) => _then(v as _InsertArticlesOneResponse));

  @override
  _InsertArticlesOneResponse get _value =>
      super._value as _InsertArticlesOneResponse;

  @override
  $Res call({
    Object? insertArticlesOne = freezed,
  }) {
    return _then(_InsertArticlesOneResponse(
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
      _$_$_InsertArticlesOneResponseFromJson(json);

  @JsonKey(defaultValue: null)
  @override
  final Article? insertArticlesOne;

  @override
  String toString() {
    return 'InsertArticlesOneResponse(insertArticlesOne: $insertArticlesOne)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _InsertArticlesOneResponse &&
            (identical(other.insertArticlesOne, insertArticlesOne) ||
                const DeepCollectionEquality()
                    .equals(other.insertArticlesOne, insertArticlesOne)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(insertArticlesOne);

  @JsonKey(ignore: true)
  @override
  _$InsertArticlesOneResponseCopyWith<_InsertArticlesOneResponse>
      get copyWith =>
          __$InsertArticlesOneResponseCopyWithImpl<_InsertArticlesOneResponse>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_InsertArticlesOneResponseToJson(this);
  }
}

abstract class _InsertArticlesOneResponse implements InsertArticlesOneResponse {
  const factory _InsertArticlesOneResponse({Article? insertArticlesOne}) =
      _$_InsertArticlesOneResponse;

  factory _InsertArticlesOneResponse.fromJson(Map<String, dynamic> json) =
      _$_InsertArticlesOneResponse.fromJson;

  @override
  Article? get insertArticlesOne => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$InsertArticlesOneResponseCopyWith<_InsertArticlesOneResponse>
      get copyWith => throw _privateConstructorUsedError;
}

ArticleListResponse _$ArticleListResponseFromJson(Map<String, dynamic> json) {
  return _ArticleListResponse.fromJson(json);
}

/// @nodoc
class _$ArticleListResponseTearOff {
  const _$ArticleListResponseTearOff();

  _ArticleListResponse call({List<Article> articles = const <Article>[]}) {
    return _ArticleListResponse(
      articles: articles,
    );
  }

  ArticleListResponse fromJson(Map<String, Object> json) {
    return ArticleListResponse.fromJson(json);
  }
}

/// @nodoc
const $ArticleListResponse = _$ArticleListResponseTearOff();

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
abstract class _$ArticleListResponseCopyWith<$Res>
    implements $ArticleListResponseCopyWith<$Res> {
  factory _$ArticleListResponseCopyWith(_ArticleListResponse value,
          $Res Function(_ArticleListResponse) then) =
      __$ArticleListResponseCopyWithImpl<$Res>;
  @override
  $Res call({List<Article> articles});
}

/// @nodoc
class __$ArticleListResponseCopyWithImpl<$Res>
    extends _$ArticleListResponseCopyWithImpl<$Res>
    implements _$ArticleListResponseCopyWith<$Res> {
  __$ArticleListResponseCopyWithImpl(
      _ArticleListResponse _value, $Res Function(_ArticleListResponse) _then)
      : super(_value, (v) => _then(v as _ArticleListResponse));

  @override
  _ArticleListResponse get _value => super._value as _ArticleListResponse;

  @override
  $Res call({
    Object? articles = freezed,
  }) {
    return _then(_ArticleListResponse(
      articles: articles == freezed
          ? _value.articles
          : articles // ignore: cast_nullable_to_non_nullable
              as List<Article>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ArticleListResponse implements _ArticleListResponse {
  const _$_ArticleListResponse({this.articles = const <Article>[]});

  factory _$_ArticleListResponse.fromJson(Map<String, dynamic> json) =>
      _$_$_ArticleListResponseFromJson(json);

  @JsonKey(defaultValue: const <Article>[])
  @override
  final List<Article> articles;

  @override
  String toString() {
    return 'ArticleListResponse(articles: $articles)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ArticleListResponse &&
            (identical(other.articles, articles) ||
                const DeepCollectionEquality()
                    .equals(other.articles, articles)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(articles);

  @JsonKey(ignore: true)
  @override
  _$ArticleListResponseCopyWith<_ArticleListResponse> get copyWith =>
      __$ArticleListResponseCopyWithImpl<_ArticleListResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ArticleListResponseToJson(this);
  }
}

abstract class _ArticleListResponse implements ArticleListResponse {
  const factory _ArticleListResponse({List<Article> articles}) =
      _$_ArticleListResponse;

  factory _ArticleListResponse.fromJson(Map<String, dynamic> json) =
      _$_ArticleListResponse.fromJson;

  @override
  List<Article> get articles => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ArticleListResponseCopyWith<_ArticleListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return _Article.fromJson(json);
}

/// @nodoc
class _$ArticleTearOff {
  const _$ArticleTearOff();

  _Article call(
      {String id = '',
      String title = '',
      String url = '',
      String urlToImage = 'http://placehold.jp/150x150.png',
      String publishedAt = '',
      List<Favorite> favorites = const <Favorite>[]}) {
    return _Article(
      id: id,
      title: title,
      url: url,
      urlToImage: urlToImage,
      publishedAt: publishedAt,
      favorites: favorites,
    );
  }

  Article fromJson(Map<String, Object> json) {
    return Article.fromJson(json);
  }
}

/// @nodoc
const $Article = _$ArticleTearOff();

/// @nodoc
mixin _$Article {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get urlToImage => throw _privateConstructorUsedError;
  String get publishedAt => throw _privateConstructorUsedError;
  List<Favorite> get favorites => throw _privateConstructorUsedError;

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
      List<Favorite> favorites});
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
    Object? favorites = freezed,
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
      favorites: favorites == freezed
          ? _value.favorites
          : favorites // ignore: cast_nullable_to_non_nullable
              as List<Favorite>,
    ));
  }
}

/// @nodoc
abstract class _$ArticleCopyWith<$Res> implements $ArticleCopyWith<$Res> {
  factory _$ArticleCopyWith(_Article value, $Res Function(_Article) then) =
      __$ArticleCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String title,
      String url,
      String urlToImage,
      String publishedAt,
      List<Favorite> favorites});
}

/// @nodoc
class __$ArticleCopyWithImpl<$Res> extends _$ArticleCopyWithImpl<$Res>
    implements _$ArticleCopyWith<$Res> {
  __$ArticleCopyWithImpl(_Article _value, $Res Function(_Article) _then)
      : super(_value, (v) => _then(v as _Article));

  @override
  _Article get _value => super._value as _Article;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? url = freezed,
    Object? urlToImage = freezed,
    Object? publishedAt = freezed,
    Object? favorites = freezed,
  }) {
    return _then(_Article(
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
      favorites: favorites == freezed
          ? _value.favorites
          : favorites // ignore: cast_nullable_to_non_nullable
              as List<Favorite>,
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
      this.favorites = const <Favorite>[]});

  factory _$_Article.fromJson(Map<String, dynamic> json) =>
      _$_$_ArticleFromJson(json);

  @JsonKey(defaultValue: '')
  @override
  final String id;
  @JsonKey(defaultValue: '')
  @override
  final String title;
  @JsonKey(defaultValue: '')
  @override
  final String url;
  @JsonKey(defaultValue: 'http://placehold.jp/150x150.png')
  @override
  final String urlToImage;
  @JsonKey(defaultValue: '')
  @override
  final String publishedAt;
  @JsonKey(defaultValue: const <Favorite>[])
  @override
  final List<Favorite> favorites;

  @override
  String toString() {
    return 'Article(id: $id, title: $title, url: $url, urlToImage: $urlToImage, publishedAt: $publishedAt, favorites: $favorites)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Article &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.urlToImage, urlToImage) ||
                const DeepCollectionEquality()
                    .equals(other.urlToImage, urlToImage)) &&
            (identical(other.publishedAt, publishedAt) ||
                const DeepCollectionEquality()
                    .equals(other.publishedAt, publishedAt)) &&
            (identical(other.favorites, favorites) ||
                const DeepCollectionEquality()
                    .equals(other.favorites, favorites)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(url) ^
      const DeepCollectionEquality().hash(urlToImage) ^
      const DeepCollectionEquality().hash(publishedAt) ^
      const DeepCollectionEquality().hash(favorites);

  @JsonKey(ignore: true)
  @override
  _$ArticleCopyWith<_Article> get copyWith =>
      __$ArticleCopyWithImpl<_Article>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ArticleToJson(this);
  }
}

abstract class _Article implements Article {
  const factory _Article(
      {String id,
      String title,
      String url,
      String urlToImage,
      String publishedAt,
      List<Favorite> favorites}) = _$_Article;

  factory _Article.fromJson(Map<String, dynamic> json) = _$_Article.fromJson;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  String get title => throw _privateConstructorUsedError;
  @override
  String get url => throw _privateConstructorUsedError;
  @override
  String get urlToImage => throw _privateConstructorUsedError;
  @override
  String get publishedAt => throw _privateConstructorUsedError;
  @override
  List<Favorite> get favorites => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ArticleCopyWith<_Article> get copyWith =>
      throw _privateConstructorUsedError;
}
