// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'comment_create_page_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
abstract class _$$_CommentCreatePageStateCopyWith<$Res>
    implements $CommentCreatePageStateCopyWith<$Res> {
  factory _$$_CommentCreatePageStateCopyWith(_$_CommentCreatePageState value,
          $Res Function(_$_CommentCreatePageState) then) =
      __$$_CommentCreatePageStateCopyWithImpl<$Res>;
  @override
  $Res call({String commentText});
}

/// @nodoc
class __$$_CommentCreatePageStateCopyWithImpl<$Res>
    extends _$CommentCreatePageStateCopyWithImpl<$Res>
    implements _$$_CommentCreatePageStateCopyWith<$Res> {
  __$$_CommentCreatePageStateCopyWithImpl(_$_CommentCreatePageState _value,
      $Res Function(_$_CommentCreatePageState) _then)
      : super(_value, (v) => _then(v as _$_CommentCreatePageState));

  @override
  _$_CommentCreatePageState get _value =>
      super._value as _$_CommentCreatePageState;

  @override
  $Res call({
    Object? commentText = freezed,
  }) {
    return _then(_$_CommentCreatePageState(
      commentText: commentText == freezed
          ? _value.commentText
          : commentText // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_CommentCreatePageState implements _CommentCreatePageState {
  const _$_CommentCreatePageState({this.commentText = ''});

  @override
  @JsonKey()
  final String commentText;

  @override
  String toString() {
    return 'CommentCreatePageState(commentText: $commentText)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CommentCreatePageState &&
            const DeepCollectionEquality()
                .equals(other.commentText, commentText));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(commentText));

  @JsonKey(ignore: true)
  @override
  _$$_CommentCreatePageStateCopyWith<_$_CommentCreatePageState> get copyWith =>
      __$$_CommentCreatePageStateCopyWithImpl<_$_CommentCreatePageState>(
          this, _$identity);
}

abstract class _CommentCreatePageState implements CommentCreatePageState {
  const factory _CommentCreatePageState({final String commentText}) =
      _$_CommentCreatePageState;

  @override
  String get commentText;
  @override
  @JsonKey(ignore: true)
  _$$_CommentCreatePageStateCopyWith<_$_CommentCreatePageState> get copyWith =>
      throw _privateConstructorUsedError;
}
