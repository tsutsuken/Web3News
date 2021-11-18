// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'comment_list_page_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$CommentListPageStateTearOff {
  const _$CommentListPageStateTearOff();

  _CommentListPageState call(
      {AsyncValue<List<Comment>> commentsValue =
          const AsyncValue<List<Comment>>.loading()}) {
    return _CommentListPageState(
      commentsValue: commentsValue,
    );
  }
}

/// @nodoc
const $CommentListPageState = _$CommentListPageStateTearOff();

/// @nodoc
mixin _$CommentListPageState {
  AsyncValue<List<Comment>> get commentsValue =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CommentListPageStateCopyWith<CommentListPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentListPageStateCopyWith<$Res> {
  factory $CommentListPageStateCopyWith(CommentListPageState value,
          $Res Function(CommentListPageState) then) =
      _$CommentListPageStateCopyWithImpl<$Res>;
  $Res call({AsyncValue<List<Comment>> commentsValue});
}

/// @nodoc
class _$CommentListPageStateCopyWithImpl<$Res>
    implements $CommentListPageStateCopyWith<$Res> {
  _$CommentListPageStateCopyWithImpl(this._value, this._then);

  final CommentListPageState _value;
  // ignore: unused_field
  final $Res Function(CommentListPageState) _then;

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
abstract class _$CommentListPageStateCopyWith<$Res>
    implements $CommentListPageStateCopyWith<$Res> {
  factory _$CommentListPageStateCopyWith(_CommentListPageState value,
          $Res Function(_CommentListPageState) then) =
      __$CommentListPageStateCopyWithImpl<$Res>;
  @override
  $Res call({AsyncValue<List<Comment>> commentsValue});
}

/// @nodoc
class __$CommentListPageStateCopyWithImpl<$Res>
    extends _$CommentListPageStateCopyWithImpl<$Res>
    implements _$CommentListPageStateCopyWith<$Res> {
  __$CommentListPageStateCopyWithImpl(
      _CommentListPageState _value, $Res Function(_CommentListPageState) _then)
      : super(_value, (v) => _then(v as _CommentListPageState));

  @override
  _CommentListPageState get _value => super._value as _CommentListPageState;

  @override
  $Res call({
    Object? commentsValue = freezed,
  }) {
    return _then(_CommentListPageState(
      commentsValue: commentsValue == freezed
          ? _value.commentsValue
          : commentsValue // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<Comment>>,
    ));
  }
}

/// @nodoc

class _$_CommentListPageState
    with DiagnosticableTreeMixin
    implements _CommentListPageState {
  const _$_CommentListPageState(
      {this.commentsValue = const AsyncValue<List<Comment>>.loading()});

  @JsonKey(defaultValue: const AsyncValue<List<Comment>>.loading())
  @override
  final AsyncValue<List<Comment>> commentsValue;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CommentListPageState(commentsValue: $commentsValue)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CommentListPageState'))
      ..add(DiagnosticsProperty('commentsValue', commentsValue));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CommentListPageState &&
            (identical(other.commentsValue, commentsValue) ||
                other.commentsValue == commentsValue));
  }

  @override
  int get hashCode => Object.hash(runtimeType, commentsValue);

  @JsonKey(ignore: true)
  @override
  _$CommentListPageStateCopyWith<_CommentListPageState> get copyWith =>
      __$CommentListPageStateCopyWithImpl<_CommentListPageState>(
          this, _$identity);
}

abstract class _CommentListPageState implements CommentListPageState {
  const factory _CommentListPageState(
      {AsyncValue<List<Comment>> commentsValue}) = _$_CommentListPageState;

  @override
  AsyncValue<List<Comment>> get commentsValue;
  @override
  @JsonKey(ignore: true)
  _$CommentListPageStateCopyWith<_CommentListPageState> get copyWith =>
      throw _privateConstructorUsedError;
}
