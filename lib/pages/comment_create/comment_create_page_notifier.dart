import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/models/article/article_repository.dart';
import 'package:labo_flutter/models/comment/comment_repository.dart';

final commentCreatePageNotifierProvider = ChangeNotifierProvider.autoDispose(
  (ref) {
    return CommentCreatePageNotifier(ref.read);
  },
);

class ResponseAddCommentAndArticle {
  const ResponseAddCommentAndArticle(
      {required this.didAddComment, required this.articleId});
  final bool didAddComment;
  final String? articleId;
}

class CommentCreatePageNotifier extends ChangeNotifier {
  CommentCreatePageNotifier(this._reader);

  final Reader _reader;

  late final ArticleRepository articleRepository =
      _reader(articleRepositoryProvider);
  late final CommentRepository commentRepository =
      _reader(commentRepositoryProvider);
  String commentText = '';

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

      final didAddComment = await addComment(newArticleId, commentText);
      return ResponseAddCommentAndArticle(
          didAddComment: didAddComment, articleId: newArticleId);
    } else {
      // コメントを追加
      final didAddComment = await addComment(_articleId, commentText);
      return ResponseAddCommentAndArticle(
          didAddComment: didAddComment, articleId: _articleId);
    }
  }

  Future<bool> addComment(String articleId, String text) async {
    final didAddComment = await commentRepository.addComment(articleId, text);
    return didAddComment;
  }

  Future<String?> addArticle(String url) async {
    final addedArticleId = await articleRepository.addArticle(url);
    return addedArticleId;
  }
}
