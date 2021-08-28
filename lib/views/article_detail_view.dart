import 'dart:io';

import 'package:flutter/material.dart';
import 'package:labo_flutter/views/comment_list_view.dart';
import 'package:labo_flutter/views/create_post_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleDetailView extends StatefulWidget {
  const ArticleDetailView(
      {Key? key, required this.articleId, required this.articleUrl})
      : super(key: key);

  final String articleId;
  final String articleUrl;

  @override
  _ArticleDetailViewState createState() => _ArticleDetailViewState();
}

class _ArticleDetailViewState extends State<ArticleDetailView> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ArticleDetailView'),
      ),
      body: WebView(
        initialUrl: widget.articleUrl,
        javascriptMode: JavascriptMode.unrestricted,
        gestureNavigationEnabled: true,
      ),
      bottomNavigationBar: BottomAppBar(
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
                      builder: (context) => CreatePostView(
                        articleId: widget.articleId,
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
                        articleUrl: widget.articleUrl,
                      ),
                      fullscreenDialog: true,
                    ),
                  );
                },
                icon: const Icon(Icons.chat))
          ],
        ),
      ),
    );
  }
}
