// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'comment_create_page_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$CommentCreatePageStateTearOff {
  const _$CommentCreatePageStateTearOff();

  _CommentCreatePageState call({String commentText = ''}) {
    return _CommentCreatePageState(
      commentText: commentText,
    );
  }
}

/// @nodoc
const $CommentCreatePageState = _$CommentCreatePageStateTearOff();

/// @nodoc
mixin _$CommentCreatePageState {
  String get commentText => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CommentCreatePageStateCopyWith<CommentCreatePageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentCreatePageStateCopyWith<$Res> {
  factory $CommentCreatePageStateCopyWith(CommentCreatePageState value,
          $Res Function(CommentCreatePageState) then) =
      _$CommentCreatePageStateCopyWithImpl<$Res>;
  $Res call({String commentText});
}

/// @nodoc
class _$CommentCreatePageStateCopyWithImpl<$Res>
    implements $CommentCreatePageStateCopyWith<$Res> {
  _$CommentCreatePageStateCopyWithImpl(this._value, this._then);

  final CommentCreatePageState _value;
  // ignore: unused_field
  final $Res Function(CommentCreatePageState) _then;

  @override
  $Res call({
    Object? commentText = freezed,
  }) {
    return _then(_value.copyWith(
      commentText: commentText == freezed
          ? _value.commentText
          : commentText // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$CommentCreatePageStateCopyWith<$Res>
    implements $CommentCreatePageStateCopyWith<$Res> {
  factory _$CommentCreatePageStateCopyWith(_CommentCreatePageState value,
          $Res Function(_CommentCreatePageState) then) =
      __$CommentCreatePageStateCopyWithImpl<$Res>;
  @override
  $Res call({String commentText});
}

/// @nodoc
class __$CommentCreatePageStateCopyWithImpl<$Res>
    extends _$CommentCreatePageStateCopyWithImpl<$Res>
    implements _$CommentCreatePageStateCopyWith<$Res> {
  __$CommentCreatePageStateCopyWithImpl(_CommentCreatePageState _value,
      $Res Function(_CommentCreatePageState) _then)
      : super(_value, (v) => _then(v as _CommentCreatePageState));

  @override
  _CommentCreatePageState get _value => super._value as _CommentCreatePageState;

  @override
  $Res call({
    Object? commentText = freezed,
  }) {
    return _then(_CommentCreatePageState(
      commentText: commentText == freezed
          ? _value.commentText
          : commentText // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_CommentCreatePageState
    with DiagnosticableTreeMixin
    implements _CommentCreatePageState {
  const _$_CommentCreatePageState({this.commentText = ''});

  @JsonKey(defaultValue: '')
  @override
  final String commentText;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CommentCreatePageState(commentText: $commentText)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CommentCreatePageState'))
      ..add(DiagnosticsProperty('commentText', commentText));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CommentCreatePageState &&
            (identical(other.commentText, commentText) ||
                other.commentText == commentText));
  }

  @override
  int get hashCode => Object.hash(runtimeType, commentText);

  @JsonKey(ignore: true)
  @override
  _$CommentCreatePageStateCopyWith<_CommentCreatePageState> get copyWith =>
      __$CommentCreatePageStateCopyWithImpl<_CommentCreatePageState>(
          this, _$identity);
}

abstract class _CommentCreatePageState implements CommentCreatePageState {
  const factory _CommentCreatePageState({String commentText}) =
      _$_CommentCreatePageState;

  @override
  String get commentText;
  @override
  @JsonKey(ignore: true)
  _$CommentCreatePageStateCopyWith<_CommentCreatePageState> get copyWith =>
      throw _privateConstructorUsedError;
}
