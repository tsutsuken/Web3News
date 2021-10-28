// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CommentListResponse _$$_CommentListResponseFromJson(
        Map<String, dynamic> json) =>
    _$_CommentListResponse(
      comments: (json['comments'] as List<dynamic>?)
              ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$$_CommentListResponseToJson(
        _$_CommentListResponse instance) =>
    <String, dynamic>{
      'comments': instance.comments,
    };

_$_CommentListFilteredResponse _$$_CommentListFilteredResponseFromJson(
        Map<String, dynamic> json) =>
    _$_CommentListFilteredResponse(
      commentsFiltered: (json['comments_filtered'] as List<dynamic>?)
              ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$$_CommentListFilteredResponseToJson(
        _$_CommentListFilteredResponse instance) =>
    <String, dynamic>{
      'comments_filtered': instance.commentsFiltered,
    };

_$_Comment _$$_CommentFromJson(Map<String, dynamic> json) => _$_Comment(
      id: json['id'] as String? ?? '',
      text: json['text'] as String? ?? '',
      userId: json['user_id'] as String? ?? '',
      articleId: json['article_id'] as String? ?? '',
      createdAt: json['created_at'] as String? ?? '',
      user: json['user'] == null
          ? null
          : AppUser.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_CommentToJson(_$_Comment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'user_id': instance.userId,
      'article_id': instance.articleId,
      'created_at': instance.createdAt,
      'user': instance.user,
    };
