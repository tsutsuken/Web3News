// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppUser _$_$_AppUserFromJson(Map<String, dynamic> json) {
  return _$_AppUser(
    id: json['id'] as String? ?? '',
    name: json['name'] as String? ?? '',
    createdAt: json['createdAt'] as String? ?? '',
    profileImageUrl:
        json['profileImageUrl'] as String? ?? 'http://placehold.jp/150x150.png',
  );
}

Map<String, dynamic> _$_$_AppUserToJson(_$_AppUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt,
      'profileImageUrl': instance.profileImageUrl,
    };
