// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppUserResponse _$$_AppUserResponseFromJson(Map<String, dynamic> json) =>
    _$_AppUserResponse(
      usersByPk: json['users_by_pk'] == null
          ? null
          : AppUser.fromJson(json['users_by_pk'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_AppUserResponseToJson(_$_AppUserResponse instance) =>
    <String, dynamic>{
      'users_by_pk': instance.usersByPk,
    };

_$_AppUser _$$_AppUserFromJson(Map<String, dynamic> json) => _$_AppUser(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      createdAt: json['created_at'] as String? ?? '',
      profileImageUrl: json['profile_image_url'] as String? ??
          'http://placehold.jp/150x150.png',
    );

Map<String, dynamic> _$$_AppUserToJson(_$_AppUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'created_at': instance.createdAt,
      'profile_image_url': instance.profileImageUrl,
    };
