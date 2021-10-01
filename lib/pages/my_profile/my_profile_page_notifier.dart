import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/models/comment/comment.dart';
import 'package:labo_flutter/models/comment/comment_repository.dart';

final myProfilePageNotifierProvider = ChangeNotifierProvider.family
    .autoDispose<MyProfilePageNotifier, MyProfilePageContentType>(
  (ref, contentType) {
    final commentRepository = ref.read(commentRepositoryProvider);
    return MyProfilePageNotifier(commentRepository, contentType);
  },
);

enum MyProfilePageContentType {
  ascendingMyComments,
  descendingMyComments,
}

class MyProfilePageNotifier extends ChangeNotifier {
  MyProfilePageNotifier(this._commentRepository, this.contentType) {
    fetchMyComments();
  }

  final CommentRepository _commentRepository;
  final MyProfilePageContentType contentType;
  AsyncValue<List<Comment>> commentsValue = const AsyncValue.loading();

  Future<void> fetchMyComments() async {
    debugPrint('ttmm fetchMyComments 0');
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      commentsValue = const AsyncValue.data([]);
      notifyListeners();
      return;
    }

    var orderType = CommentsOrderType.ascending;
    if (contentType == MyProfilePageContentType.descendingMyComments) {
      orderType = CommentsOrderType.descending;
    }

    debugPrint('ttmm fetchMyComments 1');
    try {
      final _comments = await _commentRepository.fetchCommentsOfUser(
        userId,
        orderType,
      );
      commentsValue = AsyncValue.data(_comments);
      notifyListeners();
    } on Exception catch (e) {
      debugPrint('fetchMyComments error: $e');
      commentsValue = AsyncValue.error(e);
      notifyListeners();
    }
  }

  Future<bool> deleteComment(String commentId) async {
    final didSuccess = await _commentRepository.deleteComment(commentId);
    return didSuccess;
  }
}
