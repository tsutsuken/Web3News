// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'comment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CommentListResponse _$CommentListResponseFromJson(Map<String, dynamic> json) {
  return _CommentListResponse.fromJson(json);
}

/// @nodoc
class _$CommentListResponseTearOff {
  const _$CommentListResponseTearOff();

  _CommentListResponse call({List<Comment> comments = const <Comment>[]}) {
    return _CommentListResponse(
      comments: comments,
    );
  }

  CommentListResponse fromJson(Map<String, Object> json) {
    return CommentListResponse.fromJson(json);
  }
}

/// @nodoc
const $CommentListResponse = _$CommentListResponseTearOff();

/// @nodoc
mixin _$CommentListResponse {
  List<Comment> get comments => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CommentListResponseCopyWith<CommentListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentListResponseCopyWith<$Res> {
  factory $CommentListResponseCopyWith(
          CommentListResponse value, $Res Function(CommentListResponse) then) =
      _$CommentListResponseCopyWithImpl<$Res>;
  $Res call({List<Comment> comments});
}

/// @nodoc
class _$CommentListResponseCopyWithImpl<$Res>
    implements $CommentListResponseCopyWith<$Res> {
  _$CommentListResponseCopyWithImpl(this._value, this._then);

  final CommentListResponse _value;
  // ignore: unused_field
  final $Res Function(CommentListResponse) _then;

  @override
  $Res call({
    Object? comments = freezed,
  }) {
    return _then(_value.copyWith(
      comments: comments == freezed
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<Comment>,
    ));
  }
}

/// @nodoc
abstract class _$CommentListResponseCopyWith<$Res>
    implements $CommentListResponseCopyWith<$Res> {
  factory _$CommentListResponseCopyWith(_CommentListResponse value,
          $Res Function(_CommentListResponse) then) =
      __$CommentListResponseCopyWithImpl<$Res>;
  @override
  $Res call({List<Comment> comments});
}

/// @nodoc
class __$CommentListResponseCopyWithImpl<$Res>
    extends _$CommentListResponseCopyWithImpl<$Res>
    implements _$CommentListResponseCopyWith<$Res> {
  __$CommentListResponseCopyWithImpl(
      _CommentListResponse _value, $Res Function(_CommentListResponse) _then)
      : super(_value, (v) => _then(v as _CommentListResponse));

  @override
  _CommentListResponse get _value => super._value as _CommentListResponse;

  @override
  $Res call({
    Object? comments = freezed,
  }) {
    return _then(_CommentListResponse(
      comments: comments == freezed
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<Comment>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CommentListResponse implements _CommentListResponse {
  const _$_CommentListResponse({this.comments = const <Comment>[]});

  factory _$_CommentListResponse.fromJson(Map<String, dynamic> json) =>
      _$_$_CommentListResponseFromJson(json);

  @JsonKey(defaultValue: const <Comment>[])
  @override
  final List<Comment> comments;

  @override
  String toString() {
    return 'CommentListResponse(comments: $comments)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CommentListResponse &&
            (identical(other.comments, comments) ||
                const DeepCollectionEquality()
                    .equals(other.comments, comments)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(comments);

  @JsonKey(ignore: true)
  @override
  _$CommentListResponseCopyWith<_CommentListResponse> get copyWith =>
      __$CommentListResponseCopyWithImpl<_CommentListResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CommentListResponseToJson(this);
  }
}

abstract class _CommentListResponse implements CommentListResponse {
  const factory _CommentListResponse({List<Comment> comments}) =
      _$_CommentListResponse;

  factory _CommentListResponse.fromJson(Map<String, dynamic> json) =
      _$_CommentListResponse.fromJson;

  @override
  List<Comment> get comments => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CommentListResponseCopyWith<_CommentListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return _Comment.fromJson(json);
}

/// @nodoc
class _$CommentTearOff {
  const _$CommentTearOff();

  _Comment call({String text = ''}) {
    return _Comment(
      text: text,
    );
  }

  Comment fromJson(Map<String, Object> json) {
    return Comment.fromJson(json);
  }
}

/// @nodoc
const $Comment = _$CommentTearOff();

/// @nodoc
mixin _$Comment {
  String get text => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CommentCopyWith<Comment> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentCopyWith<$Res> {
  factory $CommentCopyWith(Comment value, $Res Function(Comment) then) =
      _$CommentCopyWithImpl<$Res>;
  $Res call({String text});
}

/// @nodoc
class _$CommentCopyWithImpl<$Res> implements $CommentCopyWith<$Res> {
  _$CommentCopyWithImpl(this._value, this._then);

  final Comment _value;
  // ignore: unused_field
  final $Res Function(Comment) _then;

  @override
  $Res call({
    Object? text = freezed,
  }) {
    return _then(_value.copyWith(
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$CommentCopyWith<$Res> implements $CommentCopyWith<$Res> {
  factory _$CommentCopyWith(_Comment value, $Res Function(_Comment) then) =
      __$CommentCopyWithImpl<$Res>;
  @override
  $Res call({String text});
}

/// @nodoc
class __$CommentCopyWithImpl<$Res> extends _$CommentCopyWithImpl<$Res>
    implements _$CommentCopyWith<$Res> {
  __$CommentCopyWithImpl(_Comment _value, $Res Function(_Comment) _then)
      : super(_value, (v) => _then(v as _Comment));

  @override
  _Comment get _value => super._value as _Comment;

  @override
  $Res call({
    Object? text = freezed,
  }) {
    return _then(_Comment(
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Comment implements _Comment {
  const _$_Comment({this.text = ''});

  factory _$_Comment.fromJson(Map<String, dynamic> json) =>
      _$_$_CommentFromJson(json);

  @JsonKey(defaultValue: '')
  @override
  final String text;

  @override
  String toString() {
    return 'Comment(text: $text)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Comment &&
            (identical(other.text, text) ||
                const DeepCollectionEquality().equals(other.text, text)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(text);

  @JsonKey(ignore: true)
  @override
  _$CommentCopyWith<_Comment> get copyWith =>
      __$CommentCopyWithImpl<_Comment>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CommentToJson(this);
  }
}

abstract class _Comment implements Comment {
  const factory _Comment({String text}) = _$_Comment;

  factory _Comment.fromJson(Map<String, dynamic> json) = _$_Comment.fromJson;

  @override
  String get text => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CommentCopyWith<_Comment> get copyWith =>
      throw _privateConstructorUsedError;
}