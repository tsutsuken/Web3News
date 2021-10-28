import 'package:flutter/material.dart';
import 'package:labo_flutter/utils/app_colors.dart';

Future<void> showArticleBottomSheet({
  required BuildContext context,
  required bool isFavorite,
  required VoidCallback onTapFavorite,
}) async {
  final favoriteMenuTitle = isFavorite ? 'お気に入りから削除' : 'お気に入りに追加';
  await showModalBottomSheet<void>(
    context: context,
    builder: (context) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.delete),
              title: Text(
                favoriteMenuTitle,
                style: TextStyle(color: AppColors().textPrimary),
              ),
              onTap: () {
                onTapFavorite();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}
