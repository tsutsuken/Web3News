// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_InsertArticlesOneResponse _$_$_InsertArticlesOneResponseFromJson(
    Map<String, dynamic> json) {
  return _$_InsertArticlesOneResponse(
    insertArticlesOne: json['insert_articles_one'] == null
        ? null
        : Article.fromJson(json['insert_articles_one'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$_InsertArticlesOneResponseToJson(
        _$_InsertArticlesOneResponse instance) =>
    <String, dynamic>{
      'insert_articles_one': instance.insertArticlesOne,
    };

_$_ArticleListResponse _$_$_ArticleListResponseFromJson(
    Map<String, dynamic> json) {
  return _$_ArticleListResponse(
    articles: (json['articles'] as List<dynamic>?)
            ?.map((e) => Article.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
  );
}

Map<String, dynamic> _$_$_ArticleListResponseToJson(
        _$_ArticleListResponse instance) =>
    <String, dynamic>{
      'articles': instance.articles,
    };

_$_Article _$_$_ArticleFromJson(Map<String, dynamic> json) {
  return _$_Article(
    id: json['id'] as String? ?? '',
    title: json['title'] as String? ?? '',
    url: json['url'] as String? ?? '',
    urlToImage:
        json['url_to_image'] as String? ?? 'http://placehold.jp/150x150.png',
    publishedAt: json['published_at'] as String? ?? '',
    favorites: (json['favorites'] as List<dynamic>?)
            ?.map((e) => Favorite.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
  );
}

Map<String, dynamic> _$_$_ArticleToJson(_$_Article instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'url': instance.url,
      'url_to_image': instance.urlToImage,
      'published_at': instance.publishedAt,
      'favorites': instance.favorites,
    };
