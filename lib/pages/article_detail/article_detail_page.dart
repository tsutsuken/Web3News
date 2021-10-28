import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/pages/article_detail/article_detail_page_notifier.dart';
import 'package:labo_flutter/pages/comment_create/comment_create_page.dart';
import 'package:labo_flutter/pages/comment_list/comment_list_page.dart';
import 'package:labo_flutter/pages/promote_sign_in_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleDetailPage extends HookConsumerWidget {
  const ArticleDetailPage(
      {Key? key,
      required this.articleId,
      required this.articleUrl,
      required this.isFavorite})
      : super(key: key);

  final String? articleId;
  final String articleUrl;
  final bool isFavorite;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // article追加時にarticleIdの変更を反映させるため
    final articleIdNotifier = useState(articleId);
    final isFavoriteNotifier = useState(isFavorite);
    final pageNotifierParams = ArticleDetailPageNotifierParams(
      articleUrl: articleUrl,
      articleId: articleIdNotifier.value,
      isFavorite: isFavoriteNotifier.value,
    );
    final pageNotifier =
        ref.watch(articleDetailPageNotifierProvider(pageNotifierParams));

    Future<void> _fetchArticleIfNeeded() async {
      if (articleId != null) {
        return;
      }

      final article = await pageNotifier.fetchArticle();
      if (article != null) {
        articleIdNotifier.value = article.id;
        isFavoriteNotifier.value = article.favorites.isNotEmpty;
      }
    }

    useEffect(() {
      _fetchArticleIfNeeded();
      if (Platform.isAndroid) {
        // Androidで日本語入力を可能にするため
        WebView.platform = SurfaceAndroidWebView();
      }
    }, const []);

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
            articleUrl: pageNotifier.articleUrl,
          ),
          fullscreenDialog: true,
        ),
      );
      articleIdNotifier.value = articleId;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('ArticleDetailPage'),
      ),
      body: WebView(
        initialUrl: pageNotifier.articleUrl,
        javascriptMode: JavascriptMode.unrestricted,
        gestureNavigationEnabled: true,
        navigationDelegate: (_navigationRequest) {
          // ページ遷移が発生する場合、新しい画面を開く
          if (_navigationRequest.isForMainFrame &&
              _navigationRequest.url != pageNotifier.articleUrl) {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => ArticleDetailPage(
                  articleId: null,
                  articleUrl: _navigationRequest.url,
                  isFavorite: false,
                ),
              ),
            );
            return NavigationDecision.prevent;
          } else {
            return NavigationDecision.navigate;
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  if (FirebaseAuth.instance.currentUser == null) {
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
              icon: const Icon(Icons.chat),
            ),
            IconButton(
              color: Theme.of(context).primaryColor,
              onPressed: () async {
                // 通信前に表示を切り替える
                isFavoriteNotifier.value = !isFavoriteNotifier.value;
                // 通信する
                final response = await pageNotifier.updateFavorite(
                    shouldFavorite: isFavoriteNotifier.value);
                articleIdNotifier.value =
                    response.articleId; // articleを追加した場合に必要
                // 通信に失敗した場合、表示を元に戻す＆通知
                if (!response.didSuccess) {
                  isFavoriteNotifier.value = !isFavoriteNotifier.value;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('エラーが発生しました'),
                    ),
                  );
                }
              },
              icon: isFavoriteNotifier.value
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_border),
            ),
          ],
        ),
      ),
    );
  }
}
