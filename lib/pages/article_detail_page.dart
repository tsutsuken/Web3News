import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/pages/comment_create_page.dart';
import 'package:labo_flutter/pages/comment_list_page.dart';
import 'package:labo_flutter/pages/promote_sign_in_page.dart';
import 'package:labo_flutter/providers/user_change_notifier_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleDetailPage extends HookWidget {
  const ArticleDetailPage(
      {Key? key, required this.articleId, required this.articleUrl})
      : super(key: key);

  final String? articleId;
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
      body: buildWebView(context),
      bottomNavigationBar: ArticleDetailBottomAppBar(
          articleId: articleId, articleUrl: articleUrl, context: context),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text('ArticleDetailPage'),
    );
  }

  WebView buildWebView(BuildContext context) {
    return WebView(
      initialUrl: articleUrl,
      javascriptMode: JavascriptMode.unrestricted,
      gestureNavigationEnabled: true,
      navigationDelegate: (_navigationRequest) {
        // ページ遷移が発生する場合、新しい画面を開く
        if (_navigationRequest.isForMainFrame &&
            _navigationRequest.url != articleUrl) {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => ArticleDetailPage(
                articleId: null,
                articleUrl: _navigationRequest.url,
              ),
            ),
          );
          return NavigationDecision.prevent;
        } else {
          return NavigationDecision.navigate;
        }
      },
    );
  }
}

class ArticleDetailBottomAppBar extends HookConsumerWidget {
  const ArticleDetailBottomAppBar({
    Key? key,
    required this.articleId,
    required this.articleUrl,
    required this.context,
  }) : super(key: key);

  final String? articleId;
  final String articleUrl;
  final BuildContext context;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // article追加時にarticleIdの変更を反映させるため
    final articleIdNotifier = useState(articleId);
    final _userChangeNotifier = ref.watch(userChangeNotifierProvider);

    void _showPromoteSignInPage() {
      showGeneralDialog(
        transitionDuration: const Duration(milliseconds: 400),
        context: context,
        pageBuilder: (context, anim1, anim2) {
          return const PromoteSignInPage();
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

    Future<void> _showCommentCreatePage() async {
      // 未登録記事へのコメントを追加した場合、登録した記事のarticleIdが返ってくる
      final articleId = await Navigator.push(
        context,
        MaterialPageRoute<String?>(
          builder: (context) => CommentCreatePage(
            articleId: articleIdNotifier.value,
            articleUrl: articleUrl,
          ),
          fullscreenDialog: true,
        ),
      );
      articleIdNotifier.value = articleId;
    }

    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                if (_userChangeNotifier.currentUser == null) {
                  _showPromoteSignInPage();
                } else {
                  _showCommentCreatePage();
                }
              },
              icon: const Icon(Icons.add_comment)),
          IconButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => CommentListPage(
                      articleId: articleIdNotifier.value,
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
