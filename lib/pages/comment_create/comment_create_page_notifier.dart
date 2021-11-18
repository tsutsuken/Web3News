import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/models/article/article_repository.dart';
import 'package:labo_flutter/models/cloud_functions_repository.dart';
import 'package:labo_flutter/models/comment/comment_repository.dart';

part 'comment_create_page_notifier.freezed.dart';

final commentCreatePageNotifierProvider = StateNotifierProvider.autoDispose<
    CommentCreatePageNotifier, CommentCreatePageState>(
  (ref) {
    return CommentCreatePageNotifier(ref.read);
  },
);

@freezed
abstract class CommentCreatePageState with _$CommentCreatePageState {
  const factory CommentCreatePageState({
    @Default('') String commentText,
  }) = _CommentCreatePageState;
}

class ResponseAddCommentAndArticle {
  const ResponseAddCommentAndArticle(
      {required this.didAddComment, required this.articleId});
  final bool didAddComment;
  final String? articleId;
}

class CommentCreatePageNotifier extends StateNotifier<CommentCreatePageState> {
  CommentCreatePageNotifier(this._reader)
      : super(const CommentCreatePageState());

  final Reader _reader;

  late final ArticleRepository articleRepository =
      _reader(articleRepositoryProvider);
  late final CommentRepository commentRepository =
      _reader(commentRepositoryProvider);
  late final CloudFunctionsRepository cloudFunctionsRepository =
      _reader(cloudFunctionsRepositoryProvider);

  Future<ResponseAddCommentAndArticle> addCommentAndArticleIfNeeded(
    String? _articleId,
    String _articleUrl,
  ) async {
    if (_articleId == null) {
      final newArticleId = await addArticle(_articleUrl);
      if (newArticleId == null) {
        return const ResponseAddCommentAndArticle(
            didAddComment: false, articleId: null);
      }

      final didAddComment = await addComment(newArticleId, state.commentText);
      return ResponseAddCommentAndArticle(
          didAddComment: didAddComment, articleId: newArticleId);
    } else {
      // コメントを追加
      final didAddComment = await addComment(_articleId, state.commentText);
      return ResponseAddCommentAndArticle(
          didAddComment: didAddComment, articleId: _articleId);
    }
  }

  Future<bool> addComment(String articleId, String text) async {
    final didAddComment = await commentRepository.addComment(articleId, text);
    return didAddComment;
  }

  Future<String?> addArticle(String url) async {
    final addedArticleId = await cloudFunctionsRepository.addArticleByUrl(url);
    return addedArticleId;
  }

  void setCommentText(String text) {
    state = state.copyWith(
      commentText: text,
    );
  }
}
