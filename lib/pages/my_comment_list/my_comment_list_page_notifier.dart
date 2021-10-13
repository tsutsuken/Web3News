import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/models/comment/comment.dart';
import 'package:labo_flutter/models/comment/comment_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

final myCommentListPageNotifierProvider = ChangeNotifierProvider.autoDispose(
  (ref) {
    return MyCommentListPageNotifier(ref.read);
  },
);

class MyCommentListPageNotifier extends ChangeNotifier {
  MyCommentListPageNotifier(this._reader) {
    fetchMyComments();
  }

  final Reader _reader;

  late final CommentRepository _commentRepository =
      _reader(commentRepositoryProvider);
  final RefreshController refreshController = RefreshController();
  AsyncValue<List<Comment>> commentsValue = const AsyncValue.loading();
  QueryResult? _previousResultFetchComments;
  final int _limitFetchComments = 20;
  int _offsetFetchComments = 0;

  Future<void> fetchMyComments() async {
    debugPrint('fetchMyComments');
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      commentsValue = const AsyncValue.data([]);
      notifyListeners();
      return;
    }

    final result = await _commentRepository.fetchCommentsOfUser(
        userId: userId, limit: _limitFetchComments);

    if (result.hasException) {
      final exception = result.exception.toString();
      debugPrint('fetchMyComments exception: $exception');
      commentsValue = AsyncValue.error(exception);
      notifyListeners();
      return;
    }

    var comments = <Comment>[];
    final resultData = result.data;
    if (resultData != null) {
      comments = CommentListResponse.fromJson(resultData).comments;
    }
    commentsValue = AsyncValue.data(comments);
    notifyListeners();
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
      commentsValue = AsyncValue.error(exception);
      notifyListeners();
      refreshController.loadComplete();
      return;
    }

    var comments = <Comment>[];
    final resultData = result.data;
    if (resultData != null) {
      comments = CommentListResponse.fromJson(resultData).comments;
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

  Future<void> onRefresh() async {
    await fetchMyComments();
    refreshController.refreshCompleted();
  }

  Future<bool> deleteComment(String commentId) async {
    final didSuccess = await _commentRepository.deleteComment(commentId);
    return didSuccess;
  }
}
