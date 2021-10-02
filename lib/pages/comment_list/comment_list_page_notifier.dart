import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/models/comment/comment.dart';
import 'package:labo_flutter/models/comment/comment_repository.dart';
import 'package:labo_flutter/models/report/report_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

final commentListPageNotifierProvider = ChangeNotifierProvider.family
    .autoDispose<CommentListPageNotifier, String?>((ref, articleId) {
  final commentRepository = ref.read(commentRepositoryProvider);
  final reportRepository = ref.read(reportRepositoryProvider);
  return CommentListPageNotifier(
      commentRepository, reportRepository, articleId);
});

class CommentListPageNotifier extends ChangeNotifier {
  CommentListPageNotifier(
    this._commentRepository,
    this._reportRepository,
    this._articleId,
  ) {
    fetchComments(_articleId);
  }

  final CommentRepository _commentRepository;
  final ReportRepository _reportRepository;
  final String? _articleId;

  AsyncValue<List<Comment>> commentsValue = const AsyncValue.loading();
  final RefreshController refreshController = RefreshController();

  Future<void> fetchComments(String? articleId) async {
    if (articleId == null) {
      commentsValue = const AsyncValue.data([]);
      notifyListeners();
      return;
    }

    try {
      final _comments = await _commentRepository.fetchComments(articleId);
      commentsValue = AsyncValue.data(_comments);
      notifyListeners();
    } on Exception catch (e) {
      debugPrint('fetchComments error: $e');
      commentsValue = AsyncValue.error(e);
      notifyListeners();
    }
  }

  Future<bool> deleteComment(String commentId) async {
    final didSuccess = await _commentRepository.deleteComment(commentId);
    return didSuccess;
  }

  Future<void> onRefresh() async {
    await fetchComments(_articleId);
    refreshController.refreshCompleted();
  }

  Future<bool> addReport(String commentId) async {
    final didSuccess = await _reportRepository.addReport(commentId);
    return didSuccess;
  }
}
