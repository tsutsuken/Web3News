import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:labo_flutter/models/article/article.dart';

part 'favorite.freezed.dart';
part 'favorite.g.dart';

@freezed
abstract class FavoriteListResponse with _$FavoriteListResponse {
  const factory FavoriteListResponse({
    @Default(<Favorite>[]) List<Favorite> favorites,
  }) = _FavoriteListResponse;

  factory FavoriteListResponse.fromJson(Map<String, dynamic> json) =>
      _$FavoriteListResponseFromJson(json);
}

@freezed
abstract class Favorite with _$Favorite {
  const factory Favorite({
    @Default('') String id,
    @Default('') String userId,
    @Default('') String articleId,
    @Default('') String createdAt,
    Article? article,
  }) = _Favorite;

  factory Favorite.fromJson(Map<String, dynamic> json) =>
      _$FavoriteFromJson(json);
}
