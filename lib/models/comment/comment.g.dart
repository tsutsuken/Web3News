// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CommentListResponse _$_$_CommentListResponseFromJson(
    Map<String, dynamic> json) {
  return _$_CommentListResponse(
    comments: (json['comments'] as List<dynamic>?)
            ?.map((dynamic e) => Comment.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
  );
}

Map<String, dynamic> _$_$_CommentListResponseToJson(
        _$_CommentListResponse instance) =>
    <String, dynamic>{
      'comments': instance.comments,
    };

_$_Comment _$_$_CommentFromJson(Map<String, dynamic> json) {
  return _$_Comment(
    id: json['id'] as String? ?? '',
    text: json['text'] as String? ?? '',
    userId: json['user_id'] as String? ?? '',
    articleId: json['article_id'] as String? ?? '',
    createdAt: json['created_at'] as String? ?? '',
  );
}

Map<String, dynamic> _$_$_CommentToJson(_$_Comment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'user_id': instance.userId,
      'article_id': instance.articleId,
      'created_at': instance.createdAt,
    };
