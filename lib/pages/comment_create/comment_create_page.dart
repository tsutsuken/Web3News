import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/pages/comment_create/comment_create_page_notifier.dart';
import 'package:labo_flutter/utils/app_colors.dart';

class CommentCreatePage extends HookConsumerWidget {
  const CommentCreatePage(
      {Key? key, required this.articleId, required this.articleUrl})
      : super(key: key);

  final String? articleId;
  final String articleUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(commentCreatePageNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CommentCreatePage'),
        actions: [
          TextButton(
            onPressed: () async {
              final response = await pageNotifier.addCommentAndArticleIfNeeded(
                articleId,
                articleUrl,
              );
              if (response.didAddComment) {
                Navigator.of(context).pop<String?>(response.articleId);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('コメントを投稿しました'),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('エラーが発生しました'),
                  ),
                );
              }
            },
            style: TextButton.styleFrom(
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            child: const Text('保存'),
          )
        ],
      ),
      body: Column(children: [
        TextField(
          autofocus: true,
          maxLines: 10,
          style: TextStyle(
            color: AppColors().textPrimary,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'コメントを書く',
          ),
          onChanged: (text) {
            pageNotifier.setCommentText(text);
          },
        ),
      ]),
    );
  }
}
