// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'comment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CommentListResponse _$CommentListResponseFromJson(Map<String, dynamic> json) {
  return _CommentListResponse.fromJson(json);
}

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
abstract class _$$_CommentListResponseCopyWith<$Res>
    implements $CommentListResponseCopyWith<$Res> {
  factory _$$_CommentListResponseCopyWith(_$_CommentListResponse value,
          $Res Function(_$_CommentListResponse) then) =
      __$$_CommentListResponseCopyWithImpl<$Res>;
  @override
  $Res call({List<Comment> comments});
}

/// @nodoc
class __$$_CommentListResponseCopyWithImpl<$Res>
    extends _$CommentListResponseCopyWithImpl<$Res>
    implements _$$_CommentListResponseCopyWith<$Res> {
  __$$_CommentListResponseCopyWithImpl(_$_CommentListResponse _value,
      $Res Function(_$_CommentListResponse) _then)
      : super(_value, (v) => _then(v as _$_CommentListResponse));

  @override
  _$_CommentListResponse get _value => super._value as _$_CommentListResponse;

  @override
  $Res call({
    Object? comments = freezed,
  }) {
    return _then(_$_CommentListResponse(
      comments: comments == freezed
          ? _value._comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<Comment>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CommentListResponse implements _CommentListResponse {
  const _$_CommentListResponse(
      {final List<Comment> comments = const <Comment>[]})
      : _comments = comments;

  factory _$_CommentListResponse.fromJson(Map<String, dynamic> json) =>
      _$$_CommentListResponseFromJson(json);

  final List<Comment> _comments;
  @override
  @JsonKey()
  List<Comment> get comments {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_comments);
  }

  @override
  String toString() {
    return 'CommentListResponse(comments: $comments)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CommentListResponse &&
            const DeepCollectionEquality().equals(other._comments, _comments));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_comments));

  @JsonKey(ignore: true)
  @override
  _$$_CommentListResponseCopyWith<_$_CommentListResponse> get copyWith =>
      __$$_CommentListResponseCopyWithImpl<_$_CommentListResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CommentListResponseToJson(
      this,
    );
  }
}

abstract class _CommentListResponse implements CommentListResponse {
  const factory _CommentListResponse({final List<Comment> comments}) =
      _$_CommentListResponse;

  factory _CommentListResponse.fromJson(Map<String, dynamic> json) =
      _$_CommentListResponse.fromJson;

  @override
  List<Comment> get comments;
  @override
  @JsonKey(ignore: true)
  _$$_CommentListResponseCopyWith<_$_CommentListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

CommentListFilteredResponse _$CommentListFilteredResponseFromJson(
    Map<String, dynamic> json) {
  return _CommentListFilteredResponse.fromJson(json);
}

/// @nodoc
mixin _$CommentListFilteredResponse {
  List<Comment> get commentsFiltered => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CommentListFilteredResponseCopyWith<CommentListFilteredResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentListFilteredResponseCopyWith<$Res> {
  factory $CommentListFilteredResponseCopyWith(
          CommentListFilteredResponse value,
          $Res Function(CommentListFilteredResponse) then) =
      _$CommentListFilteredResponseCopyWithImpl<$Res>;
  $Res call({List<Comment> commentsFiltered});
}

/// @nodoc
class _$CommentListFilteredResponseCopyWithImpl<$Res>
    implements $CommentListFilteredResponseCopyWith<$Res> {
  _$CommentListFilteredResponseCopyWithImpl(this._value, this._then);

  final CommentListFilteredResponse _value;
  // ignore: unused_field
  final $Res Function(CommentListFilteredResponse) _then;

  @override
  $Res call({
    Object? commentsFiltered = freezed,
  }) {
    return _then(_value.copyWith(
      commentsFiltered: commentsFiltered == freezed
          ? _value.commentsFiltered
          : commentsFiltered // ignore: cast_nullable_to_non_nullable
              as List<Comment>,
    ));
  }
}

/// @nodoc
abstract class _$$_CommentListFilteredResponseCopyWith<$Res>
    implements $CommentListFilteredResponseCopyWith<$Res> {
  factory _$$_CommentListFilteredResponseCopyWith(
          _$_CommentListFilteredResponse value,
          $Res Function(_$_CommentListFilteredResponse) then) =
      __$$_CommentListFilteredResponseCopyWithImpl<$Res>;
  @override
  $Res call({List<Comment> commentsFiltered});
}

/// @nodoc
class __$$_CommentListFilteredResponseCopyWithImpl<$Res>
    extends _$CommentListFilteredResponseCopyWithImpl<$Res>
    implements _$$_CommentListFilteredResponseCopyWith<$Res> {
  __$$_CommentListFilteredResponseCopyWithImpl(
      _$_CommentListFilteredResponse _value,
      $Res Function(_$_CommentListFilteredResponse) _then)
      : super(_value, (v) => _then(v as _$_CommentListFilteredResponse));

  @override
  _$_CommentListFilteredResponse get _value =>
      super._value as _$_CommentListFilteredResponse;

  @override
  $Res call({
    Object? commentsFiltered = freezed,
  }) {
    return _then(_$_CommentListFilteredResponse(
      commentsFiltered: commentsFiltered == freezed
          ? _value._commentsFiltered
          : commentsFiltered // ignore: cast_nullable_to_non_nullable
              as List<Comment>,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_CommentListFilteredResponse implements _CommentListFilteredResponse {
  const _$_CommentListFilteredResponse(
      {final List<Comment> commentsFiltered = const <Comment>[]})
      : _commentsFiltered = commentsFiltered;

  factory _$_CommentListFilteredResponse.fromJson(Map<String, dynamic> json) =>
      _$$_CommentListFilteredResponseFromJson(json);

  final List<Comment> _commentsFiltered;
  @override
  @JsonKey()
  List<Comment> get commentsFiltered {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_commentsFiltered);
  }

  @override
  String toString() {
    return 'CommentListFilteredResponse(commentsFiltered: $commentsFiltered)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CommentListFilteredResponse &&
            const DeepCollectionEquality()
                .equals(other._commentsFiltered, _commentsFiltered));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_commentsFiltered));

  @JsonKey(ignore: true)
  @override
  _$$_CommentListFilteredResponseCopyWith<_$_CommentListFilteredResponse>
      get copyWith => __$$_CommentListFilteredResponseCopyWithImpl<
          _$_CommentListFilteredResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CommentListFilteredResponseToJson(
      this,
    );
  }
}

abstract class _CommentListFilteredResponse
    implements CommentListFilteredResponse {
  const factory _CommentListFilteredResponse(
      {final List<Comment> commentsFiltered}) = _$_CommentListFilteredResponse;

  factory _CommentListFilteredResponse.fromJson(Map<String, dynamic> json) =
      _$_CommentListFilteredResponse.fromJson;

  @override
  List<Comment> get commentsFiltered;
  @override
  @JsonKey(ignore: true)
  _$$_CommentListFilteredResponseCopyWith<_$_CommentListFilteredResponse>
      get copyWith => throw _privateConstructorUsedError;
}

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return _Comment.fromJson(json);
}

/// @nodoc
mixin _$Comment {
  String get id => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get articleId => throw _privateConstructorUsedError;
  String get createdAt =>
      throw _privateConstructorUsedError; // TODO: デフォルトでAppUserのコンストラクタを指定する
  AppUser? get user => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CommentCopyWith<Comment> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentCopyWith<$Res> {
  factory $CommentCopyWith(Comment value, $Res Function(Comment) then) =
      _$CommentCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String text,
      String userId,
      String articleId,
      String createdAt,
      AppUser? user});

  $AppUserCopyWith<$Res>? get user;
}

/// @nodoc
class _$CommentCopyWithImpl<$Res> implements $CommentCopyWith<$Res> {
  _$CommentCopyWithImpl(this._value, this._then);

  final Comment _value;
  // ignore: unused_field
  final $Res Function(Comment) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? text = freezed,
    Object? userId = freezed,
    Object? articleId = freezed,
    Object? createdAt = freezed,
    Object? user = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      articleId: articleId == freezed
          ? _value.articleId
          : articleId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as AppUser?,
    ));
  }

  @override
  $AppUserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $AppUserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc
abstract class _$$_CommentCopyWith<$Res> implements $CommentCopyWith<$Res> {
  factory _$$_CommentCopyWith(
          _$_Comment value, $Res Function(_$_Comment) then) =
      __$$_CommentCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String text,
      String userId,
      String articleId,
      String createdAt,
      AppUser? user});

  @override
  $AppUserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$_CommentCopyWithImpl<$Res> extends _$CommentCopyWithImpl<$Res>
    implements _$$_CommentCopyWith<$Res> {
  __$$_CommentCopyWithImpl(_$_Comment _value, $Res Function(_$_Comment) _then)
      : super(_value, (v) => _then(v as _$_Comment));

  @override
  _$_Comment get _value => super._value as _$_Comment;

  @override
  $Res call({
    Object? id = freezed,
    Object? text = freezed,
    Object? userId = freezed,
    Object? articleId = freezed,
    Object? createdAt = freezed,
    Object? user = freezed,
  }) {
    return _then(_$_Comment(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      articleId: articleId == freezed
          ? _value.articleId
          : articleId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as AppUser?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_Comment extends _Comment {
  const _$_Comment(
      {this.id = '',
      this.text = '',
      this.userId = '',
      this.articleId = '',
      this.createdAt = '',
      this.user})
      : super._();

  factory _$_Comment.fromJson(Map<String, dynamic> json) =>
      _$$_CommentFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String text;
  @override
  @JsonKey()
  final String userId;
  @override
  @JsonKey()
  final String articleId;
  @override
  @JsonKey()
  final String createdAt;
// TODO: デフォルトでAppUserのコンストラクタを指定する
  @override
  final AppUser? user;

  @override
  String toString() {
    return 'Comment(id: $id, text: $text, userId: $userId, articleId: $articleId, createdAt: $createdAt, user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Comment &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.text, text) &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality().equals(other.articleId, articleId) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.user, user));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(text),
      const DeepCollectionEquality().hash(userId),
      const DeepCollectionEquality().hash(articleId),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(user));

  @JsonKey(ignore: true)
  @override
  _$$_CommentCopyWith<_$_Comment> get copyWith =>
      __$$_CommentCopyWithImpl<_$_Comment>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CommentToJson(
      this,
    );
  }
}

abstract class _Comment extends Comment {
  const factory _Comment(
      {final String id,
      final String text,
      final String userId,
      final String articleId,
      final String createdAt,
      final AppUser? user}) = _$_Comment;
  const _Comment._() : super._();

  factory _Comment.fromJson(Map<String, dynamic> json) = _$_Comment.fromJson;

  @override
  String get id;
  @override
  String get text;
  @override
  String get userId;
  @override
  String get articleId;
  @override
  String get createdAt;
  @override // TODO: デフォルトでAppUserのコンストラクタを指定する
  AppUser? get user;
  @override
  @JsonKey(ignore: true)
  _$$_CommentCopyWith<_$_Comment> get copyWith =>
      throw _privateConstructorUsedError;
}
