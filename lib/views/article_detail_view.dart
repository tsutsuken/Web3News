import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/providers/user_change_notifier_provider.dart';
import 'package:labo_flutter/views/comment_create_view.dart';
import 'package:labo_flutter/views/comment_list_view.dart';
import 'package:labo_flutter/views/promote_sign_in_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleDetailView extends HookWidget {
  const ArticleDetailView(
      {Key? key, required this.articleId, required this.articleUrl})
      : super(key: key);

  final String articleId;
  final String articleUrl;

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      if (Platform.isAndroid) {
        // Androidで日本語入力を可能にするため
        WebView.platform = SurfaceAndroidWebView();
      }
    }, const []);

    return Scaffold(
      appBar: buildAppBar(),
      body: buildWebView(),
      bottomNavigationBar:
          ArticleDetailBottomAppBar(articleId: articleId, context: context),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text('ArticleDetailView'),
    );
  }

  WebView buildWebView() {
    return WebView(
      initialUrl: articleUrl,
      javascriptMode: JavascriptMode.unrestricted,
      gestureNavigationEnabled: true,
    );
  }
}

class ArticleDetailBottomAppBar extends HookWidget {
  const ArticleDetailBottomAppBar({
    Key? key,
    required this.articleId,
    required this.context,
  }) : super(key: key);

  final String articleId;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final _userChangeNotifier = useProvider(userChangeNotifierProvider);

    void _showPromoteSignInView() {
      showGeneralDialog(
        transitionDuration: const Duration(milliseconds: 400),
        context: context,
        pageBuilder: (context, anim1, anim2) {
          return const PromoteSignInView();
        },
        transitionBuilder: (context, anim1, anim2, child) {
          return SlideTransition(
            position: Tween(begin: const Offset(0, 1), end: Offset.zero)
                .animate(anim1),
            child: child,
          );
        },
      );
    }

    void _showCommentCreateView() {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => CommentCreateView(
            articleId: articleId,
          ),
          fullscreenDialog: true,
        ),
      );
    }

    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                if (_userChangeNotifier.currentUser == null) {
                  _showPromoteSignInView();
                } else {
                  _showCommentCreateView();
                }
              },
              icon: const Icon(Icons.add_comment)),
          IconButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => CommentListView(
                      articleId: articleId,
                    ),
                    fullscreenDialog: true,
                  ),
                );
              },
              icon: const Icon(Icons.chat))
        ],
      ),
    );
  }
}
