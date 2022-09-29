// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'my_comment_list_page_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
abstract class _$$_MyCommentListPageStateCopyWith<$Res>
    implements $MyCommentListPageStateCopyWith<$Res> {
  factory _$$_MyCommentListPageStateCopyWith(_$_MyCommentListPageState value,
          $Res Function(_$_MyCommentListPageState) then) =
      __$$_MyCommentListPageStateCopyWithImpl<$Res>;
  @override
  $Res call({AsyncValue<List<Comment>> commentsValue});
}

/// @nodoc
class __$$_MyCommentListPageStateCopyWithImpl<$Res>
    extends _$MyCommentListPageStateCopyWithImpl<$Res>
    implements _$$_MyCommentListPageStateCopyWith<$Res> {
  __$$_MyCommentListPageStateCopyWithImpl(_$_MyCommentListPageState _value,
      $Res Function(_$_MyCommentListPageState) _then)
      : super(_value, (v) => _then(v as _$_MyCommentListPageState));

  @override
  _$_MyCommentListPageState get _value =>
      super._value as _$_MyCommentListPageState;

  @override
  $Res call({
    Object? commentsValue = freezed,
  }) {
    return _then(_$_MyCommentListPageState(
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

  @override
  @JsonKey()
  final AsyncValue<List<Comment>> commentsValue;

  @override
  String toString() {
    return 'MyCommentListPageState(commentsValue: $commentsValue)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MyCommentListPageState &&
            const DeepCollectionEquality()
                .equals(other.commentsValue, commentsValue));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(commentsValue));

  @JsonKey(ignore: true)
  @override
  _$$_MyCommentListPageStateCopyWith<_$_MyCommentListPageState> get copyWith =>
      __$$_MyCommentListPageStateCopyWithImpl<_$_MyCommentListPageState>(
          this, _$identity);
}

abstract class _MyCommentListPageState implements MyCommentListPageState {
  const factory _MyCommentListPageState(
          {final AsyncValue<List<Comment>> commentsValue}) =
      _$_MyCommentListPageState;

  @override
  AsyncValue<List<Comment>> get commentsValue;
  @override
  @JsonKey(ignore: true)
  _$$_MyCommentListPageStateCopyWith<_$_MyCommentListPageState> get copyWith =>
      throw _privateConstructorUsedError;
}
