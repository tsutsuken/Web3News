import 'package:flutter/material.dart';
import 'package:labo_flutter/components/loading_indicator.dart';
import 'package:labo_flutter/models/app_user/app_user.dart';
import 'package:labo_flutter/pages/edit_profile_page.dart';
import 'package:labo_flutter/pages/my_comment_list/my_comment_list_page.dart';
import 'package:labo_flutter/pages/my_profile/my_profile_page_notifier.dart';
import 'package:labo_flutter/utils/app_colors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyProfilePageLoggedIn extends StatelessWidget {
  const MyProfilePageLoggedIn({Key? key, required this.pageNotifier})
      : super(key: key);

  final MyProfilePageNotifier pageNotifier;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('マイページ'),
      ),
      body: pageNotifier.myAppUserValue.when(
        data: (appUser) {
          if (appUser == null) {
            return const Text('エラーが発生しました');
          }
          return SmartRefresher(
            controller: pageNotifier.refreshController,
            onRefresh: () async {
              await pageNotifier.onRefresh();
            },
            child: ListView(
              children: [
                ProfileHeaderWidget(appUser: appUser),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) => const MyCommentListPage(),
                      ),
                    );
                  },
                  leading: const Icon(Icons.chat),
                  title: Text(
                    'コメント一覧',
                    style: TextStyle(
                      color: AppColors().textPrimary,
                    ),
                  ),
                )
              ],
            ),
          );
        },
        loading: () {
          return const LoadingIndicator();
        },
        error: (error, stackTrace) {
          return Text('エラーが発生しました: $error');
        },
      ),
    );
  }
}

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({
    Key? key,
    required this.appUser,
  }) : super(key: key);

  final AppUser appUser;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 192,
      child: Center(
        child: Column(
          children: [
            Column(
              children: [
                const SizedBox(height: 12),
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(appUser.profileImageUrl)),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  appUser.name,
                  style: TextStyle(color: AppColors().textPrimary),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 36,
                  width: 160,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => const EditProfilePage(),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.white),
                    child: const Text('プロフィールを編集',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        )),
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
