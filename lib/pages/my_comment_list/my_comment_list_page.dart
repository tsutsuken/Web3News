import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/components/comment_bottom_sheet.dart';
import 'package:labo_flutter/components/comment_list_item.dart';
import 'package:labo_flutter/components/loading_indicator.dart';
import 'package:labo_flutter/components/refresher_footer.dart';
import 'package:labo_flutter/components/refresher_header.dart';
import 'package:labo_flutter/models/comment/comment.dart';
import 'package:labo_flutter/pages/my_comment_list/my_comment_list_page_notifier.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyCommentListPage extends HookConsumerWidget {
  const MyCommentListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(myCommentListPageNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('コメント一覧'),
      ),
      body: pageNotifier.commentsValue.when(
        data: (comments) {
          if (comments.isEmpty) {
            return _buildEmptyBody();
          }

          return SmartRefresher(
            controller: pageNotifier.refreshController,
            enablePullUp: true,
            header: const RefresherHeader(),
            footer: const RefresherFooter(),
            onRefresh: () async {
              await pageNotifier.onRefresh();
            },
            onLoading: () async {
              await pageNotifier.onLoadMore();
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
        loading: (_) {
          return const LoadingIndicator();
        },
        error: (error, stackTrace, _) {
          return Text('エラーが発生しました: $error');
        },
      ),
    );
  }

  Widget _buildEmptyBody() {
    return const Text('コメントはありません');
  }
}

Future<void> _onTapMenuButton(BuildContext context,
    MyCommentListPageNotifier pageNotifier, Comment comment) async {
  await showCommentBottomSheet(
    context,
    comment: comment,
    onTapDeleteComment: () async {
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

      // 画面をリロード
      if (didSuccess) {
        await pageNotifier.onRefresh();
      }
    },
  );
}
