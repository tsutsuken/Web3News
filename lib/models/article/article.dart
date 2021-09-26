import 'package:freezed_annotation/freezed_annotation.dart';

part 'article.freezed.dart';
part 'article.g.dart';

@freezed
abstract class InsertArticlesOneResponse with _$InsertArticlesOneResponse {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory InsertArticlesOneResponse({
    @Default(null) Article? insertArticlesOne,
  }) = _InsertArticlesOneResponse;

  factory InsertArticlesOneResponse.fromJson(Map<String, dynamic> json) =>
      _$InsertArticlesOneResponseFromJson(json);
}

@freezed
abstract class ArticleListResponse with _$ArticleListResponse {
  const factory ArticleListResponse({
    @Default(<Article>[]) List<Article> articles,
  }) = _ArticleListResponse;

  factory ArticleListResponse.fromJson(Map<String, dynamic> json) =>
      _$ArticleListResponseFromJson(json);
}

@freezed
abstract class Article with _$Article {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Article({
    @Default('') String id,
    @Default('') String title,
    @Default('') String url,
    @Default('http://placehold.jp/150x150.png') String urlToImage,
    @Default('') String publishedAt,
  }) = _Article;

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
}
