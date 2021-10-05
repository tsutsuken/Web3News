import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/components/comment_bottom_sheet.dart';
import 'package:labo_flutter/components/comment_list_item.dart';
import 'package:labo_flutter/components/loading_indicator.dart';
import 'package:labo_flutter/models/comment/comment.dart';
import 'package:labo_flutter/pages/comment_list/comment_list_page_notifier.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CommentListPage extends HookConsumerWidget {
  const CommentListPage({Key? key, required this.articleId}) : super(key: key);

  final String? articleId;

  Future<void> _onTapMenuButton(BuildContext context,
      CommentListPageNotifier pageNotifier, Comment comment) async {
    final isMyComment =
        FirebaseAuth.instance.currentUser?.uid == comment.userId;

    // 「コメントを削除」タップ時
    VoidCallback? onTapDeleteComment;
    if (isMyComment) {
      onTapDeleteComment = () async {
        final didSuccess = await pageNotifier.deleteComment(comment.id);

        // スナックバーを表示
        var message = '';
        if (didSuccess) {
          message = '削除しました';
        } else {
          message = 'エラーが発生しました。もう一度お試しください';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );

        // 画面をリロード
        if (didSuccess) {
          await pageNotifier.onRefresh();
        }
      };
    }

    // 「不適切なコンテンツを報告」タップ時
    VoidCallback? onTapReportContent;
    if (!isMyComment) {
      onTapReportContent = () async {
        final didSuccess = await pageNotifier.addReport(comment.id);
        debugPrint('onTapReportContent didSuccess: $didSuccess');

        // スナックバーを表示
        var message = '';
        if (didSuccess) {
          message = '報告しました';
        } else {
          message = 'エラーが発生しました。もう一度お試しください';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      };
    }

    // 「このユーザをブロック」タップ時
    VoidCallback? onTapBlockUser;
    if (!isMyComment) {
      onTapBlockUser = () async {
        final didSuccess = await pageNotifier.blockUser(comment.userId);
        debugPrint('onTapBlockUser didSuccess: $didSuccess');

        // スナックバーを表示
        var message = '';
        if (didSuccess) {
          message = 'ユーザをブロックしました';
        } else {
          message = 'エラーが発生しました。もう一度お試しください';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );

        // 画面をリロード
        if (didSuccess) {
          await pageNotifier.onRefresh();
        }
      };
    }

    await showCommentBottomSheet(
      context,
      comment: comment,
      onTapDeleteComment: onTapDeleteComment,
      onTapReportContent: onTapReportContent,
      onTapBlockUser: onTapBlockUser,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(commentListPageNotifierProvider(articleId));

    return Scaffold(
      appBar: AppBar(title: const Text('CommentListPage')),
      body: (articleId == null)
          ? _buildEmptyBody()
          : _buildCommentsQuery(pageNotifier),
    );
  }

  Widget _buildEmptyBody() {
    return const Text('最初のコメントを投稿しましょう');
  }

  Widget _buildCommentsQuery(CommentListPageNotifier pageNotifier) {
    return pageNotifier.commentsValue.when(
      data: (comments) {
        if (comments.isEmpty) {
          return _buildEmptyBody();
        }

        return SmartRefresher(
          controller: pageNotifier.refreshController,
          onRefresh: () async {
            await pageNotifier.onRefresh();
          },
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: comments.length,
            itemBuilder: (BuildContext context, int index) {
              final comment = comments[index];
              return CommentListItem(
                comment: comment,
                onTapMenuButton: () async {
                  await _onTapMenuButton(context, pageNotifier, comment);
                },
              );
            },
          ),
        );
      },
      loading: () {
        return const LoadingIndicator();
      },
      error: (error, stackTrace) {
        return Text('エラーが発生しました: $error');
      },
    );
  }
}
