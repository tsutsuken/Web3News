import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/models/comment/comment.dart';
import 'package:labo_flutter/models/comment/comment_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'my_comment_list_page_notifier.freezed.dart';

final myCommentListPageNotifierProvider = StateNotifierProvider.autoDispose<
    MyCommentListPageNotifier,
    MyCommentListPageState>((ref) => MyCommentListPageNotifier(ref.read));

@freezed
abstract class MyCommentListPageState with _$MyCommentListPageState {
  const factory MyCommentListPageState({
    @Default(AsyncValue<List<Comment>>.loading())
        AsyncValue<List<Comment>> commentsValue,
  }) = _MyCommentListPageState;
}

class MyCommentListPageNotifier extends StateNotifier<MyCommentListPageState> {
  MyCommentListPageNotifier(this._reader)
      : super(const MyCommentListPageState()) {
    fetchMyComments();
  }

  final Reader _reader;

  late final CommentRepository _commentRepository =
      _reader(commentRepositoryProvider);
  final RefreshController refreshController = RefreshController();
  QueryResult? _previousResultFetchComments;
  final int _limitFetchComments = 20;
  int _offsetFetchComments = 0;

  Future<void> fetchMyComments() async {
    debugPrint('fetchMyComments');
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      state = state.copyWith(
        commentsValue: const AsyncValue.data([]),
      );
      return;
    }

    final result = await _commentRepository.fetchCommentsOfUser(
        userId: userId, limit: _limitFetchComments);

    if (result.hasException) {
      final exception = result.exception.toString();
      debugPrint('fetchMyComments exception: $exception');
      state = state.copyWith(
        commentsValue: AsyncValue.error(exception),
      );
      return;
    }

    var comments = <Comment>[];
    final resultData = result.data;
    if (resultData != null) {
      comments = CommentListResponse.fromJson(resultData).comments;
    }
    state = state.copyWith(
      commentsValue: AsyncValue.data(comments),
    );
    setVariablesForLoadMore(result, comments.length);
  }

  Future<void> onLoadMore() async {
    debugPrint('onLoadMore');
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null || _previousResultFetchComments == null) {
      refreshController.loadComplete();
      return;
    }

    final result = await _commentRepository.fetchMoreCommentsOfUser(
      userId: userId,
      limit: _limitFetchComments,
      offset: _offsetFetchComments,
      previousResult: _previousResultFetchComments!,
    );

    if (result.hasException) {
      final exception = result.exception.toString();
      debugPrint('onLoadMore exception: $exception');
      state = state.copyWith(
        commentsValue: AsyncValue.error(exception),
      );
      refreshController.loadComplete();
      return;
    }

    var comments = <Comment>[];
    final resultData = result.data;
    if (resultData != null) {
      comments = CommentListResponse.fromJson(resultData).comments;
    }
    state = state.copyWith(
      commentsValue: AsyncValue.data(comments),
    );
    setVariablesForLoadMore(result, comments.length);
    refreshController.loadComplete();
  }

  void setVariablesForLoadMore(QueryResult result, int lengthOfList) {
    _previousResultFetchComments = result;
    _offsetFetchComments = lengthOfList;
  }

  Future<void> onRefresh() async {
    await fetchMyComments();
    refreshController.refreshCompleted();
  }

  Future<bool> deleteComment(String commentId) async {
    final didSuccess = await _commentRepository.deleteComment(commentId);
    return didSuccess;
  }
}
