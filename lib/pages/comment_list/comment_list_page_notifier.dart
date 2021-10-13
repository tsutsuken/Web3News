import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/models/block/block_repository.dart';
import 'package:labo_flutter/models/comment/comment.dart';
import 'package:labo_flutter/models/comment/comment_repository.dart';
import 'package:labo_flutter/models/report/report_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

final commentListPageNotifierProvider = ChangeNotifierProvider.family
    .autoDispose<CommentListPageNotifier, String?>((ref, articleId) {
  return CommentListPageNotifier(ref.read, articleId);
});

class CommentListPageNotifier extends ChangeNotifier {
  CommentListPageNotifier(
    this._reader,
    this._articleId,
  ) {
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
  AsyncValue<List<Comment>> commentsValue = const AsyncValue.loading();
  late QueryResult? _previousResultFetchComments;
  final int _limitFetchComments = 20;
  int _offsetFetchComments = 0;

  Future<void> fetchCommentsOfArticle() async {
    debugPrint('fetchCommentsOfArticle articleId: $_articleId');
    if (_articleId == null) {
      commentsValue = const AsyncValue.data([]);
      notifyListeners();
      return;
    }

    final result = await _commentRepository.fetchCommentsOfArticle(
        articleId: _articleId!, limit: _limitFetchComments);

    if (result.hasException) {
      final exception = result.exception.toString();
      debugPrint('fetchCommentsOfArticle exception: $exception');
      commentsValue = AsyncValue.error(exception);
      notifyListeners();
      return;
    }

    var comments = <Comment>[];
    final resultData = result.data;
    if (resultData != null) {
      comments =
          CommentListFilteredResponse.fromJson(resultData).commentsFiltered;
    }
    commentsValue = AsyncValue.data(comments);
    notifyListeners();
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
      commentsValue = AsyncValue.error(exception);
      notifyListeners();
      refreshController.loadComplete();
      return;
    }

    var comments = <Comment>[];
    final resultData = result.data;
    if (resultData != null) {
      comments =
          CommentListFilteredResponse.fromJson(resultData).commentsFiltered;
    }
    commentsValue = AsyncValue.data(comments);
    notifyListeners();
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
