import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:labo_flutter/models/comment/comment.dart';
import 'package:labo_flutter/utils/app_colors.dart';

class CommentListItem extends StatelessWidget {
  const CommentListItem({Key? key, required this.comment}) : super(key: key);

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(width: 1, color: Colors.grey))),
          child: Row(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
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
                ],
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comment.user?.name ?? '',
                    style: TextStyle(color: AppColors().textPrimary),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    comment.text,
                    style: TextStyle(color: AppColors().textPrimary),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    comment.createdAtTimeAgo(),
                    style: TextStyle(color: AppColors().textPrimary),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
