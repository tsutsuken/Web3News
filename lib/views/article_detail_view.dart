import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:labo_flutter/views/comment_create_view.dart';
import 'package:labo_flutter/views/comment_list_view.dart';
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
      bottomNavigationBar: _buildBottomAppBar(context),
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

  BottomAppBar _buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => CommentCreateView(
                      articleId: articleId,
                    ),
                    fullscreenDialog: true,
                  ),
                );
              },
              icon: const Icon(Icons.add_comment)),
          IconButton(
              color: Colors.white,
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
