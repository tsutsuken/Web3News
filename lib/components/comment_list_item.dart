import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:labo_flutter/models/comment/comment.dart';
import 'package:labo_flutter/utils/app_colors.dart';

class CommentListItem extends StatelessWidget {
  const CommentListItem({Key? key, required this.comment, this.onTapMenuButton})
      : super(key: key);

  final Comment comment;
  final VoidCallback? onTapMenuButton;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 44,
              width: 44,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(44 / 2),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: comment.user?.profileImageUrl ?? '',
                  errorWidget: (context, url, dynamic error) =>
                      Image.asset('assets/images/default_article.png'),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      comment.user?.name ?? '',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      comment.createdAtTimeAgo(),
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  comment.text,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: onTapMenuButton,
                  child: Icon(
                    Icons.more_horiz,
                    color: AppColors().textSecondary,
                    size: 24,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
