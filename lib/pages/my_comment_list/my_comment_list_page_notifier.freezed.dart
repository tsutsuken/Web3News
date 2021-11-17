// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'my_comment_list_page_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$MyCommentListPageStateTearOff {
  const _$MyCommentListPageStateTearOff();

  _MyCommentListPageState call(
      {AsyncValue<List<Comment>> commentsValue =
          const AsyncValue<List<Comment>>.loading()}) {
    return _MyCommentListPageState(
      commentsValue: commentsValue,
    );
  }
}

/// @nodoc
const $MyCommentListPageState = _$MyCommentListPageStateTearOff();

/// @nodoc
mixin _$MyCommentListPageState {
  AsyncValue<List<Comment>> get commentsValue =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MyCommentListPageStateCopyWith<MyCommentListPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyCommentListPageStateCopyWith<$Res> {
  factory $MyCommentListPageStateCopyWith(MyCommentListPageState value,
          $Res Function(MyCommentListPageState) then) =
      _$MyCommentListPageStateCopyWithImpl<$Res>;
  $Res call({AsyncValue<List<Comment>> commentsValue});
}

/// @nodoc
class _$MyCommentListPageStateCopyWithImpl<$Res>
    implements $MyCommentListPageStateCopyWith<$Res> {
  _$MyCommentListPageStateCopyWithImpl(this._value, this._then);

  final MyCommentListPageState _value;
  // ignore: unused_field
  final $Res Function(MyCommentListPageState) _then;

  @override
  $Res call({
    Object? commentsValue = freezed,
  }) {
    return _then(_value.copyWith(
      commentsValue: commentsValue == freezed
          ? _value.commentsValue
          : commentsValue // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<Comment>>,
    ));
  }
}

/// @nodoc
abstract class _$MyCommentListPageStateCopyWith<$Res>
    implements $MyCommentListPageStateCopyWith<$Res> {
  factory _$MyCommentListPageStateCopyWith(_MyCommentListPageState value,
          $Res Function(_MyCommentListPageState) then) =
      __$MyCommentListPageStateCopyWithImpl<$Res>;
  @override
  $Res call({AsyncValue<List<Comment>> commentsValue});
}

/// @nodoc
class __$MyCommentListPageStateCopyWithImpl<$Res>
    extends _$MyCommentListPageStateCopyWithImpl<$Res>
    implements _$MyCommentListPageStateCopyWith<$Res> {
  __$MyCommentListPageStateCopyWithImpl(_MyCommentListPageState _value,
      $Res Function(_MyCommentListPageState) _then)
      : super(_value, (v) => _then(v as _MyCommentListPageState));

  @override
  _MyCommentListPageState get _value => super._value as _MyCommentListPageState;

  @override
  $Res call({
    Object? commentsValue = freezed,
  }) {
    return _then(_MyCommentListPageState(
      commentsValue: commentsValue == freezed
          ? _value.commentsValue
          : commentsValue // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<Comment>>,
    ));
  }
}

/// @nodoc

class _$_MyCommentListPageState implements _MyCommentListPageState {
  const _$_MyCommentListPageState(
      {this.commentsValue = const AsyncValue<List<Comment>>.loading()});

  @JsonKey(defaultValue: const AsyncValue<List<Comment>>.loading())
  @override
  final AsyncValue<List<Comment>> commentsValue;

  @override
  String toString() {
    return 'MyCommentListPageState(commentsValue: $commentsValue)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MyCommentListPageState &&
            (identical(other.commentsValue, commentsValue) ||
                other.commentsValue == commentsValue));
  }

  @override
  int get hashCode => Object.hash(runtimeType, commentsValue);

  @JsonKey(ignore: true)
  @override
  _$MyCommentListPageStateCopyWith<_MyCommentListPageState> get copyWith =>
      __$MyCommentListPageStateCopyWithImpl<_MyCommentListPageState>(
          this, _$identity);
}

abstract class _MyCommentListPageState implements MyCommentListPageState {
  const factory _MyCommentListPageState(
      {AsyncValue<List<Comment>> commentsValue}) = _$_MyCommentListPageState;

  @override
  AsyncValue<List<Comment>> get commentsValue;
  @override
  @JsonKey(ignore: true)
  _$MyCommentListPageStateCopyWith<_MyCommentListPageState> get copyWith =>
      throw _privateConstructorUsedError;
}
