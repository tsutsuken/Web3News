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
    await showCommentBottomSheet(
      context,
      comment: comment,
      onTapDeleteContent: () async {
        final didSuccess = await pageNotifier.deleteComment(comment.id);

        // スナックバーを表示
        var message = '';
        if (didSuccess) {
          message = '削除しました';
        } else {
          message = 'エラーが発信しました。もう一度お試しください';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );

        await pageNotifier.onRefresh();
      },
      onTapReportContent: () {
        debugPrint('onTapReportContent');
      },
      onTapBlockUser: () {
        debugPrint('onTapBlockUser');
      },
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
