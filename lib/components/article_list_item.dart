import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:labo_flutter/models/article/article.dart';
import 'package:labo_flutter/utils/app_colors.dart';

class ArticleListItem extends StatefulWidget {
  const ArticleListItem({
    Key? key,
    required this.context,
    required this.article,
    required this.onTap,
  }) : super(key: key);

  final BuildContext context;
  final Article article;
  final VoidCallback onTap;

  @override
  ArticleListItemState createState() => ArticleListItemState();
}

class ArticleListItemState extends State<ArticleListItem>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
          height: 120,
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(width: 1, color: Colors.grey))),
          child: Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 8),
                child: CachedNetworkImage(
                  width: 160,
                  fit: BoxFit.cover,
                  imageUrl: widget.article.urlToImage,
                  errorWidget: (context, url, dynamic error) =>
                      Image.asset('assets/images/default_article.png'),
                ),
              ),
              Flexible(
                child: Text(
                  widget.article.title,
                  style: TextStyle(
                    color: AppColors().textPrimary,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
