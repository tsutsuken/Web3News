import 'package:flutter/material.dart';
import 'package:labo_flutter/models/comment/comment.dart';
import 'package:labo_flutter/utils/app_colors.dart';

Future<void> showCommentBottomSheet(
  BuildContext context, {
  required Comment comment,
  VoidCallback? onTapDeleteComment,
  VoidCallback? onTapReportContent,
  VoidCallback? onTapBlockUser,
}) async {
  await showModalBottomSheet<void>(
    context: context,
    builder: (context) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (onTapDeleteComment != null)
              ListTile(
                leading: const Icon(Icons.delete),
                title: Text(
                  'コメントを削除',
                  style: TextStyle(color: AppColors().textPrimary),
                ),
                onTap: () {
                  onTapDeleteComment();
                  Navigator.of(context).pop();
                },
              ),
            if (onTapReportContent != null)
              ListTile(
                leading: const Icon(Icons.report),
                title: Text(
                  '不適切なコンテンツを報告',
                  style: TextStyle(color: AppColors().textPrimary),
                ),
                onTap: () {
                  onTapReportContent();
                  Navigator.of(context).pop();
                },
              ),
            if (onTapBlockUser != null)
              ListTile(
                leading: const Icon(Icons.block),
                title: Text(
                  'このユーザをブロック',
                  style: TextStyle(color: AppColors().textPrimary),
                ),
                onTap: () {
                  onTapBlockUser();
                  Navigator.of(context).pop();
                },
              ),
          ],
        ),
      );
    },
  );

  return Future.value();
}
