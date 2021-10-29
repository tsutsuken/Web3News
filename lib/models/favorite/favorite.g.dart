// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FavoriteListResponse _$$_FavoriteListResponseFromJson(
        Map<String, dynamic> json) =>
    _$_FavoriteListResponse(
      favorites: (json['favorites'] as List<dynamic>?)
              ?.map((e) => Favorite.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$$_FavoriteListResponseToJson(
        _$_FavoriteListResponse instance) =>
    <String, dynamic>{
      'favorites': instance.favorites,
    };

_$_Favorite _$$_FavoriteFromJson(Map<String, dynamic> json) => _$_Favorite(
      id: json['id'] as String? ?? '',
      userId: json['user_id'] as String? ?? '',
      articleId: json['article_id'] as String? ?? '',
      createdAt: json['created_at'] as String? ?? '',
      article: json['article'] == null
          ? null
          : Article.fromJson(json['article'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_FavoriteToJson(_$_Favorite instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'article_id': instance.articleId,
      'created_at': instance.createdAt,
      'article': instance.article,
    };
