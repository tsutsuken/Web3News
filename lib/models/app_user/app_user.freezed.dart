// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'app_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AppUserResponse _$AppUserResponseFromJson(Map<String, dynamic> json) {
  return _AppUserResponse.fromJson(json);
}

/// @nodoc
mixin _$AppUserResponse {
  AppUser? get usersByPk => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppUserResponseCopyWith<AppUserResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppUserResponseCopyWith<$Res> {
  factory $AppUserResponseCopyWith(
          AppUserResponse value, $Res Function(AppUserResponse) then) =
      _$AppUserResponseCopyWithImpl<$Res>;
  $Res call({AppUser? usersByPk});

  $AppUserCopyWith<$Res>? get usersByPk;
}

/// @nodoc
class _$AppUserResponseCopyWithImpl<$Res>
    implements $AppUserResponseCopyWith<$Res> {
  _$AppUserResponseCopyWithImpl(this._value, this._then);

  final AppUserResponse _value;
  // ignore: unused_field
  final $Res Function(AppUserResponse) _then;

  @override
  $Res call({
    Object? usersByPk = freezed,
  }) {
    return _then(_value.copyWith(
      usersByPk: usersByPk == freezed
          ? _value.usersByPk
          : usersByPk // ignore: cast_nullable_to_non_nullable
              as AppUser?,
    ));
  }

  @override
  $AppUserCopyWith<$Res>? get usersByPk {
    if (_value.usersByPk == null) {
      return null;
    }

    return $AppUserCopyWith<$Res>(_value.usersByPk!, (value) {
      return _then(_value.copyWith(usersByPk: value));
    });
  }
}

/// @nodoc
abstract class _$$_AppUserResponseCopyWith<$Res>
    implements $AppUserResponseCopyWith<$Res> {
  factory _$$_AppUserResponseCopyWith(
          _$_AppUserResponse value, $Res Function(_$_AppUserResponse) then) =
      __$$_AppUserResponseCopyWithImpl<$Res>;
  @override
  $Res call({AppUser? usersByPk});

  @override
  $AppUserCopyWith<$Res>? get usersByPk;
}

/// @nodoc
class __$$_AppUserResponseCopyWithImpl<$Res>
    extends _$AppUserResponseCopyWithImpl<$Res>
    implements _$$_AppUserResponseCopyWith<$Res> {
  __$$_AppUserResponseCopyWithImpl(
      _$_AppUserResponse _value, $Res Function(_$_AppUserResponse) _then)
      : super(_value, (v) => _then(v as _$_AppUserResponse));

  @override
  _$_AppUserResponse get _value => super._value as _$_AppUserResponse;

  @override
  $Res call({
    Object? usersByPk = freezed,
  }) {
    return _then(_$_AppUserResponse(
      usersByPk: usersByPk == freezed
          ? _value.usersByPk
          : usersByPk // ignore: cast_nullable_to_non_nullable
              as AppUser?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_AppUserResponse implements _AppUserResponse {
  const _$_AppUserResponse({this.usersByPk});

  factory _$_AppUserResponse.fromJson(Map<String, dynamic> json) =>
      _$$_AppUserResponseFromJson(json);

  @override
  final AppUser? usersByPk;

  @override
  String toString() {
    return 'AppUserResponse(usersByPk: $usersByPk)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppUserResponse &&
            const DeepCollectionEquality().equals(other.usersByPk, usersByPk));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(usersByPk));

  @JsonKey(ignore: true)
  @override
  _$$_AppUserResponseCopyWith<_$_AppUserResponse> get copyWith =>
      __$$_AppUserResponseCopyWithImpl<_$_AppUserResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AppUserResponseToJson(
      this,
    );
  }
}

abstract class _AppUserResponse implements AppUserResponse {
  const factory _AppUserResponse({final AppUser? usersByPk}) =
      _$_AppUserResponse;

  factory _AppUserResponse.fromJson(Map<String, dynamic> json) =
      _$_AppUserResponse.fromJson;

  @override
  AppUser? get usersByPk;
  @override
  @JsonKey(ignore: true)
  _$$_AppUserResponseCopyWith<_$_AppUserResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

AppUser _$AppUserFromJson(Map<String, dynamic> json) {
  return _AppUser.fromJson(json);
}

/// @nodoc
mixin _$AppUser {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String get profileImageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppUserCopyWith<AppUser> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppUserCopyWith<$Res> {
  factory $AppUserCopyWith(AppUser value, $Res Function(AppUser) then) =
      _$AppUserCopyWithImpl<$Res>;
  $Res call({String id, String name, String createdAt, String profileImageUrl});
}

/// @nodoc
class _$AppUserCopyWithImpl<$Res> implements $AppUserCopyWith<$Res> {
  _$AppUserCopyWithImpl(this._value, this._then);

  final AppUser _value;
  // ignore: unused_field
  final $Res Function(AppUser) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? createdAt = freezed,
    Object? profileImageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      profileImageUrl: profileImageUrl == freezed
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_AppUserCopyWith<$Res> implements $AppUserCopyWith<$Res> {
  factory _$$_AppUserCopyWith(
          _$_AppUser value, $Res Function(_$_AppUser) then) =
      __$$_AppUserCopyWithImpl<$Res>;
  @override
  $Res call({String id, String name, String createdAt, String profileImageUrl});
}

/// @nodoc
class __$$_AppUserCopyWithImpl<$Res> extends _$AppUserCopyWithImpl<$Res>
    implements _$$_AppUserCopyWith<$Res> {
  __$$_AppUserCopyWithImpl(_$_AppUser _value, $Res Function(_$_AppUser) _then)
      : super(_value, (v) => _then(v as _$_AppUser));

  @override
  _$_AppUser get _value => super._value as _$_AppUser;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? createdAt = freezed,
    Object? profileImageUrl = freezed,
  }) {
    return _then(_$_AppUser(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      profileImageUrl: profileImageUrl == freezed
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_AppUser implements _AppUser {
  const _$_AppUser(
      {this.id = '',
      this.name = '',
      this.createdAt = '',
      this.profileImageUrl = 'http://placehold.jp/150x150.png'});

  factory _$_AppUser.fromJson(Map<String, dynamic> json) =>
      _$$_AppUserFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String createdAt;
  @override
  @JsonKey()
  final String profileImageUrl;

  @override
  String toString() {
    return 'AppUser(id: $id, name: $name, createdAt: $createdAt, profileImageUrl: $profileImageUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppUser &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality()
                .equals(other.profileImageUrl, profileImageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(profileImageUrl));

  @JsonKey(ignore: true)
  @override
  _$$_AppUserCopyWith<_$_AppUser> get copyWith =>
      __$$_AppUserCopyWithImpl<_$_AppUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AppUserToJson(
      this,
    );
  }
}

abstract class _AppUser implements AppUser {
  const factory _AppUser(
      {final String id,
      final String name,
      final String createdAt,
      final String profileImageUrl}) = _$_AppUser;

  factory _AppUser.fromJson(Map<String, dynamic> json) = _$_AppUser.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get createdAt;
  @override
  String get profileImageUrl;
  @override
  @JsonKey(ignore: true)
  _$$_AppUserCopyWith<_$_AppUser> get copyWith =>
      throw _privateConstructorUsedError;
}
