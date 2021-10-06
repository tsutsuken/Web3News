import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

@freezed
abstract class AppUserResponse with _$AppUserResponse {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory AppUserResponse({
    AppUser? usersByPk,
  }) = _AppUserResponse;

  factory AppUserResponse.fromJson(Map<String, dynamic> json) =>
      _$AppUserResponseFromJson(json);
}

@freezed
abstract class AppUser with _$AppUser {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory AppUser({
    @Default('') String id,
    @Default('') String name,
    @Default('') String createdAt,
    @Default('http://placehold.jp/150x150.png') String profileImageUrl,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}
