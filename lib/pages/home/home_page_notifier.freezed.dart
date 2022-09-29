// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'home_page_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HomePageState {
  AsyncValue<List<Article>> get articlesValue =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HomePageStateCopyWith<HomePageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomePageStateCopyWith<$Res> {
  factory $HomePageStateCopyWith(
          HomePageState value, $Res Function(HomePageState) then) =
      _$HomePageStateCopyWithImpl<$Res>;
  $Res call({AsyncValue<List<Article>> articlesValue});
}

/// @nodoc
class _$HomePageStateCopyWithImpl<$Res>
    implements $HomePageStateCopyWith<$Res> {
  _$HomePageStateCopyWithImpl(this._value, this._then);

  final HomePageState _value;
  // ignore: unused_field
  final $Res Function(HomePageState) _then;

  @override
  $Res call({
    Object? articlesValue = freezed,
  }) {
    return _then(_value.copyWith(
      articlesValue: articlesValue == freezed
          ? _value.articlesValue
          : articlesValue // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<Article>>,
    ));
  }
}

/// @nodoc
abstract class _$$_HomePageStateCopyWith<$Res>
    implements $HomePageStateCopyWith<$Res> {
  factory _$$_HomePageStateCopyWith(
          _$_HomePageState value, $Res Function(_$_HomePageState) then) =
      __$$_HomePageStateCopyWithImpl<$Res>;
  @override
  $Res call({AsyncValue<List<Article>> articlesValue});
}

/// @nodoc
class __$$_HomePageStateCopyWithImpl<$Res>
    extends _$HomePageStateCopyWithImpl<$Res>
    implements _$$_HomePageStateCopyWith<$Res> {
  __$$_HomePageStateCopyWithImpl(
      _$_HomePageState _value, $Res Function(_$_HomePageState) _then)
      : super(_value, (v) => _then(v as _$_HomePageState));

  @override
  _$_HomePageState get _value => super._value as _$_HomePageState;

  @override
  $Res call({
    Object? articlesValue = freezed,
  }) {
    return _then(_$_HomePageState(
      articlesValue: articlesValue == freezed
          ? _value.articlesValue
          : articlesValue // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<Article>>,
    ));
  }
}

/// @nodoc

class _$_HomePageState implements _HomePageState {
  const _$_HomePageState(
      {this.articlesValue = const AsyncValue<List<Article>>.loading()});

  @override
  @JsonKey()
  final AsyncValue<List<Article>> articlesValue;

  @override
  String toString() {
    return 'HomePageState(articlesValue: $articlesValue)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HomePageState &&
            const DeepCollectionEquality()
                .equals(other.articlesValue, articlesValue));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(articlesValue));

  @JsonKey(ignore: true)
  @override
  _$$_HomePageStateCopyWith<_$_HomePageState> get copyWith =>
      __$$_HomePageStateCopyWithImpl<_$_HomePageState>(this, _$identity);
}

abstract class _HomePageState implements HomePageState {
  const factory _HomePageState(
      {final AsyncValue<List<Article>> articlesValue}) = _$_HomePageState;

  @override
  AsyncValue<List<Article>> get articlesValue;
  @override
  @JsonKey(ignore: true)
  _$$_HomePageStateCopyWith<_$_HomePageState> get copyWith =>
      throw _privateConstructorUsedError;
}
