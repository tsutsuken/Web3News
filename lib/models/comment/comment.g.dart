// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CommentListResponse _$_$_CommentListResponseFromJson(
    Map<String, dynamic> json) {
  return _$_CommentListResponse(
    comments: (json['comments'] as List<dynamic>?)
            ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
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
    text: json['text'] as String? ?? '',
  );
}

Map<String, dynamic> _$_$_CommentToJson(_$_Comment instance) =>
    <String, dynamic>{
      'text': instance.text,
    };