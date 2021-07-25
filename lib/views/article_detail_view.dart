import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleDetailView extends StatefulWidget {
  const ArticleDetailView({Key? key, required this.articleUrl})
      : super(key: key);

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
        ));
  }
}
