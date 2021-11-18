import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/models/block/block_repository.dart';
import 'package:labo_flutter/models/comment/comment.dart';
import 'package:labo_flutter/models/comment/comment_repository.dart';
import 'package:labo_flutter/models/report/report_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'comment_list_page_notifier.freezed.dart';

final commentListPageNotifierProvider = StateNotifierProvider.family
    .autoDispose<CommentListPageNotifier, CommentListPageState, String?>(
        (ref, articleId) {
  return CommentListPageNotifier(ref.read, articleId);
});

@freezed
abstract class CommentListPageState with _$CommentListPageState {
  const factory CommentListPageState({
    @Default(AsyncValue<List<Comment>>.loading())
        AsyncValue<List<Comment>> commentsValue,
  }) = _CommentListPageState;
}

class CommentListPageNotifier extends StateNotifier<CommentListPageState> {
  CommentListPageNotifier(
    this._reader,
    this._articleId,
  ) : super(const CommentListPageState()) {
    fetchCommentsOfArticle();
  }

  final Reader _reader;
  final String? _articleId;

  late final CommentRepository _commentRepository =
      _reader(commentRepositoryProvider);
  late final ReportRepository _reportRepository =
      _reader(reportRepositoryProvider);
  late final BlockRepository _blockRepository =
      _reader(blockRepositoryProvider);
  final RefreshController refreshController = RefreshController();
  late QueryResult? _previousResultFetchComments;
  final int _limitFetchComments = 20;
  int _offsetFetchComments = 0;

  Future<void> fetchCommentsOfArticle() async {
    debugPrint('fetchCommentsOfArticle articleId: $_articleId');
    if (_articleId == null) {
      state = state.copyWith(
        commentsValue: const AsyncValue.data([]),
      );
      return;
    }

    final result = await _commentRepository.fetchCommentsOfArticle(
        articleId: _articleId!, limit: _limitFetchComments);

    if (result.hasException) {
      final exception = result.exception.toString();
      debugPrint('fetchCommentsOfArticle exception: $exception');
      state = state.copyWith(
        commentsValue: AsyncValue.error(exception),
      );
      return;
    }

    var comments = <Comment>[];
    final resultData = result.data;
    if (resultData != null) {
      comments =
          CommentListFilteredResponse.fromJson(resultData).commentsFiltered;
    }
    state = state.copyWith(
      commentsValue: AsyncValue.data(comments),
    );
    setVariablesForLoadMore(result, comments.length);
  }

  Future<void> onLoadMore() async {
    debugPrint('onLoadMore');
    if (_articleId == null || _previousResultFetchComments == null) {
      refreshController.loadComplete();
      return;
    }

    final result = await _commentRepository.fetchMoreCommentsOfArticle(
      articleId: _articleId!,
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
      comments =
          CommentListFilteredResponse.fromJson(resultData).commentsFiltered;
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

  Future<bool> deleteComment(String commentId) async {
    final didSuccess = await _commentRepository.deleteComment(commentId);
    return didSuccess;
  }

  Future<void> onRefresh() async {
    await fetchCommentsOfArticle();
    refreshController.refreshCompleted();
  }

  Future<bool> addReport(String commentId) async {
    final didSuccess = await _reportRepository.addReport(commentId);
    return didSuccess;
  }

  Future<bool> blockUser(String userId) async {
    final didSuccess = await _blockRepository.blockUser(userId);
    return didSuccess;
  }
}
