import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:labo_flutter/models/app_user/app_user.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

@freezed
abstract class CommentListResponse with _$CommentListResponse {
  const factory CommentListResponse({
    @Default(<Comment>[]) List<Comment> comments,
  }) = _CommentListResponse;

  factory CommentListResponse.fromJson(Map<String, dynamic> json) =>
      _$CommentListResponseFromJson(json);
}

@freezed
abstract class Comment with _$Comment {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Comment({
    @Default('') String id,
    @Default('') String text,
    @Default('') String userId,
    @Default('') String articleId,
    @Default('') String createdAt,
    // TODO: デフォルトでAppUserのコンストラクタを指定する
    AppUser? user,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}
