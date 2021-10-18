// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FavoriteListResponse _$_$_FavoriteListResponseFromJson(
    Map<String, dynamic> json) {
  return _$_FavoriteListResponse(
    favorites: (json['favorites'] as List<dynamic>?)
            ?.map((e) => Favorite.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
  );
}

Map<String, dynamic> _$_$_FavoriteListResponseToJson(
        _$_FavoriteListResponse instance) =>
    <String, dynamic>{
      'favorites': instance.favorites,
    };

_$_Favorite _$_$_FavoriteFromJson(Map<String, dynamic> json) {
  return _$_Favorite(
    id: json['id'] as String? ?? '',
    userId: json['userId'] as String? ?? '',
    articleId: json['articleId'] as String? ?? '',
    createdAt: json['createdAt'] as String? ?? '',
    article: json['article'] == null
        ? null
        : Article.fromJson(json['article'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$_FavoriteToJson(_$_Favorite instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'articleId': instance.articleId,
      'createdAt': instance.createdAt,
      'article': instance.article,
    };
