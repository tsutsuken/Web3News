// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'my_profile_page_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MyProfilePageState {
  AsyncValue<AppUser?> get myAppUserValue => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MyProfilePageStateCopyWith<MyProfilePageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyProfilePageStateCopyWith<$Res> {
  factory $MyProfilePageStateCopyWith(
          MyProfilePageState value, $Res Function(MyProfilePageState) then) =
      _$MyProfilePageStateCopyWithImpl<$Res>;
  $Res call({AsyncValue<AppUser?> myAppUserValue});
}

/// @nodoc
class _$MyProfilePageStateCopyWithImpl<$Res>
    implements $MyProfilePageStateCopyWith<$Res> {
  _$MyProfilePageStateCopyWithImpl(this._value, this._then);

  final MyProfilePageState _value;
  // ignore: unused_field
  final $Res Function(MyProfilePageState) _then;

  @override
  $Res call({
    Object? myAppUserValue = freezed,
  }) {
    return _then(_value.copyWith(
      myAppUserValue: myAppUserValue == freezed
          ? _value.myAppUserValue
          : myAppUserValue // ignore: cast_nullable_to_non_nullable
              as AsyncValue<AppUser?>,
    ));
  }
}

/// @nodoc
abstract class _$$_MyProfilePageStateCopyWith<$Res>
    implements $MyProfilePageStateCopyWith<$Res> {
  factory _$$_MyProfilePageStateCopyWith(_$_MyProfilePageState value,
          $Res Function(_$_MyProfilePageState) then) =
      __$$_MyProfilePageStateCopyWithImpl<$Res>;
  @override
  $Res call({AsyncValue<AppUser?> myAppUserValue});
}

/// @nodoc
class __$$_MyProfilePageStateCopyWithImpl<$Res>
    extends _$MyProfilePageStateCopyWithImpl<$Res>
    implements _$$_MyProfilePageStateCopyWith<$Res> {
  __$$_MyProfilePageStateCopyWithImpl(
      _$_MyProfilePageState _value, $Res Function(_$_MyProfilePageState) _then)
      : super(_value, (v) => _then(v as _$_MyProfilePageState));

  @override
  _$_MyProfilePageState get _value => super._value as _$_MyProfilePageState;

  @override
  $Res call({
    Object? myAppUserValue = freezed,
  }) {
    return _then(_$_MyProfilePageState(
      myAppUserValue: myAppUserValue == freezed
          ? _value.myAppUserValue
          : myAppUserValue // ignore: cast_nullable_to_non_nullable
              as AsyncValue<AppUser?>,
    ));
  }
}

/// @nodoc

class _$_MyProfilePageState implements _MyProfilePageState {
  const _$_MyProfilePageState(
      {this.myAppUserValue = const AsyncValue<AppUser?>.loading()});

  @override
  @JsonKey()
  final AsyncValue<AppUser?> myAppUserValue;

  @override
  String toString() {
    return 'MyProfilePageState(myAppUserValue: $myAppUserValue)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MyProfilePageState &&
            const DeepCollectionEquality()
                .equals(other.myAppUserValue, myAppUserValue));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(myAppUserValue));

  @JsonKey(ignore: true)
  @override
  _$$_MyProfilePageStateCopyWith<_$_MyProfilePageState> get copyWith =>
      __$$_MyProfilePageStateCopyWithImpl<_$_MyProfilePageState>(
          this, _$identity);
}

abstract class _MyProfilePageState implements MyProfilePageState {
  const factory _MyProfilePageState(
      {final AsyncValue<AppUser?> myAppUserValue}) = _$_MyProfilePageState;

  @override
  AsyncValue<AppUser?> get myAppUserValue;
  @override
  @JsonKey(ignore: true)
  _$$_MyProfilePageStateCopyWith<_$_MyProfilePageState> get copyWith =>
      throw _privateConstructorUsedError;
}
