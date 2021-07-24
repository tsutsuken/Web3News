// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'article.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ArticleListResponse _$ArticleListResponseFromJson(Map<String, dynamic> json) {
  return _ArticleListResponse.fromJson(json);
}

/// @nodoc
class _$ArticleListResponseTearOff {
  const _$ArticleListResponseTearOff();

  _ArticleListResponse call(
      {String status = '',
      int totalResults = 0,
      List<Article> articles = const <Article>[]}) {
    return _ArticleListResponse(
      status: status,
      totalResults: totalResults,
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
  String get status => throw _privateConstructorUsedError;
  int get totalResults => throw _privateConstructorUsedError;
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
  $Res call({String status, int totalResults, List<Article> articles});
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
    Object? status = freezed,
    Object? totalResults = freezed,
    Object? articles = freezed,
  }) {
    return _then(_value.copyWith(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      totalResults: totalResults == freezed
          ? _value.totalResults
          : totalResults // ignore: cast_nullable_to_non_nullable
              as int,
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
  $Res call({String status, int totalResults, List<Article> articles});
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
    Object? status = freezed,
    Object? totalResults = freezed,
    Object? articles = freezed,
  }) {
    return _then(_ArticleListResponse(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      totalResults: totalResults == freezed
          ? _value.totalResults
          : totalResults // ignore: cast_nullable_to_non_nullable
              as int,
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
  const _$_ArticleListResponse(
      {this.status = '',
      this.totalResults = 0,
      this.articles = const <Article>[]});

  factory _$_ArticleListResponse.fromJson(Map<String, dynamic> json) =>
      _$_$_ArticleListResponseFromJson(json);

  @JsonKey(defaultValue: '')
  @override
  final String status;
  @JsonKey(defaultValue: 0)
  @override
  final int totalResults;
  @JsonKey(defaultValue: const <Article>[])
  @override
  final List<Article> articles;

  @override
  String toString() {
    return 'ArticleListResponse(status: $status, totalResults: $totalResults, articles: $articles)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ArticleListResponse &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.totalResults, totalResults) ||
                const DeepCollectionEquality()
                    .equals(other.totalResults, totalResults)) &&
            (identical(other.articles, articles) ||
                const DeepCollectionEquality()
                    .equals(other.articles, articles)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(totalResults) ^
      const DeepCollectionEquality().hash(articles);

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
  const factory _ArticleListResponse(
      {String status,
      int totalResults,
      List<Article> articles}) = _$_ArticleListResponse;

  factory _ArticleListResponse.fromJson(Map<String, dynamic> json) =
      _$_ArticleListResponse.fromJson;

  @override
  String get status => throw _privateConstructorUsedError;
  @override
  int get totalResults => throw _privateConstructorUsedError;
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
      {String author = '',
      String title = '',
      String url = '',
      String urlToImage = '',
      String publishedAt = ''}) {
    return _Article(
      author: author,
      title: title,
      url: url,
      urlToImage: urlToImage,
      publishedAt: publishedAt,
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
  String get author => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get urlToImage => throw _privateConstructorUsedError;
  String get publishedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ArticleCopyWith<Article> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArticleCopyWith<$Res> {
  factory $ArticleCopyWith(Article value, $Res Function(Article) then) =
      _$ArticleCopyWithImpl<$Res>;
  $Res call(
      {String author,
      String title,
      String url,
      String urlToImage,
      String publishedAt});
}

/// @nodoc
class _$ArticleCopyWithImpl<$Res> implements $ArticleCopyWith<$Res> {
  _$ArticleCopyWithImpl(this._value, this._then);

  final Article _value;
  // ignore: unused_field
  final $Res Function(Article) _then;

  @override
  $Res call({
    Object? author = freezed,
    Object? title = freezed,
    Object? url = freezed,
    Object? urlToImage = freezed,
    Object? publishedAt = freezed,
  }) {
    return _then(_value.copyWith(
      author: author == freezed
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
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
    ));
  }
}

/// @nodoc
abstract class _$ArticleCopyWith<$Res> implements $ArticleCopyWith<$Res> {
  factory _$ArticleCopyWith(_Article value, $Res Function(_Article) then) =
      __$ArticleCopyWithImpl<$Res>;
  @override
  $Res call(
      {String author,
      String title,
      String url,
      String urlToImage,
      String publishedAt});
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
    Object? author = freezed,
    Object? title = freezed,
    Object? url = freezed,
    Object? urlToImage = freezed,
    Object? publishedAt = freezed,
  }) {
    return _then(_Article(
      author: author == freezed
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Article implements _Article {
  const _$_Article(
      {this.author = '',
      this.title = '',
      this.url = '',
      this.urlToImage = '',
      this.publishedAt = ''});

  factory _$_Article.fromJson(Map<String, dynamic> json) =>
      _$_$_ArticleFromJson(json);

  @JsonKey(defaultValue: '')
  @override
  final String author;
  @JsonKey(defaultValue: '')
  @override
  final String title;
  @JsonKey(defaultValue: '')
  @override
  final String url;
  @JsonKey(defaultValue: '')
  @override
  final String urlToImage;
  @JsonKey(defaultValue: '')
  @override
  final String publishedAt;

  @override
  String toString() {
    return 'Article(author: $author, title: $title, url: $url, urlToImage: $urlToImage, publishedAt: $publishedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Article &&
            (identical(other.author, author) ||
                const DeepCollectionEquality().equals(other.author, author)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.urlToImage, urlToImage) ||
                const DeepCollectionEquality()
                    .equals(other.urlToImage, urlToImage)) &&
            (identical(other.publishedAt, publishedAt) ||
                const DeepCollectionEquality()
                    .equals(other.publishedAt, publishedAt)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(author) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(url) ^
      const DeepCollectionEquality().hash(urlToImage) ^
      const DeepCollectionEquality().hash(publishedAt);

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
      {String author,
      String title,
      String url,
      String urlToImage,
      String publishedAt}) = _$_Article;

  factory _Article.fromJson(Map<String, dynamic> json) = _$_Article.fromJson;

  @override
  String get author => throw _privateConstructorUsedError;
  @override
  String get title => throw _privateConstructorUsedError;
  @override
  String get url => throw _privateConstructorUsedError;
  @override
  String get urlToImage => throw _privateConstructorUsedError;
  @override
  String get publishedAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ArticleCopyWith<_Article> get copyWith =>
      throw _privateConstructorUsedError;
}
