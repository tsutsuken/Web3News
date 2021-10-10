import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/models/comment/comment.dart';
import 'package:labo_flutter/models/comment/comment_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

final myCommentListPageNotifierProvider = ChangeNotifierProvider.autoDispose(
  (ref) {
    final commentRepository = ref.read(commentRepositoryProvider);
    return MyCommentListPageNotifier(commentRepository);
  },
);

class MyCommentListPageNotifier extends ChangeNotifier {
  MyCommentListPageNotifier(this._commentRepository) {
    fetchMyComments();
  }

  final CommentRepository _commentRepository;
  final RefreshController refreshController = RefreshController();

  AsyncValue<List<Comment>> commentsValue = const AsyncValue.loading();

  Future<void> fetchMyComments() async {
    debugPrint('fetchMyComments');
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      commentsValue = const AsyncValue.data([]);
      notifyListeners();
      return;
    }

    try {
      final _comments = await _commentRepository.fetchCommentsOfUser(userId);
      commentsValue = AsyncValue.data(_comments);
      notifyListeners();
    } on Exception catch (e) {
      debugPrint('fetchMyComments error: $e');
      commentsValue = AsyncValue.error(e);
      notifyListeners();
    }
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
