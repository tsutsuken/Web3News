// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ArticleListResponse _$_$_ArticleListResponseFromJson(
    Map<String, dynamic> json) {
  return _$_ArticleListResponse(
    status: json['status'] as String? ?? '',
    totalResults: json['totalResults'] as int? ?? 0,
    articles: (json['articles'] as List<dynamic>?)
            ?.map((e) => Article.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
  );
}

Map<String, dynamic> _$_$_ArticleListResponseToJson(
        _$_ArticleListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'totalResults': instance.totalResults,
      'articles': instance.articles,
    };

_$_Article _$_$_ArticleFromJson(Map<String, dynamic> json) {
  return _$_Article(
    author: json['author'] as String? ?? '',
    title: json['title'] as String? ?? '',
    url: json['url'] as String? ?? '',
    urlToImage: json['urlToImage'] as String? ?? '',
    publishedAt: json['publishedAt'] as String? ?? '',
  );
}

Map<String, dynamic> _$_$_ArticleToJson(_$_Article instance) =>
    <String, dynamic>{
      'author': instance.author,
      'title': instance.title,
      'url': instance.url,
      'urlToImage': instance.urlToImage,
      'publishedAt': instance.publishedAt,
    };
