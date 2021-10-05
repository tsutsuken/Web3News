import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:labo_flutter/pages/common_webview_page.dart';
import 'package:labo_flutter/utils/app_colors.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('ログアウトしました'),
                ),
              );
            },
            leading: const Icon(Icons.logout),
            title: Text(
              'ログアウト',
              style: TextStyle(
                color: AppColors().textPrimary,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.assignment),
            title: Text(
              '利用規約',
              style: TextStyle(
                color: AppColors().textPrimary,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<String?>(
                  builder: (context) => const CommonWebviewPage(
                    title: '利用規約',
                    url: 'https://policies.google.com/terms?hl=ja&fg=1',
                  ),
                  fullscreenDialog: true,
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.security),
            title: Text(
              'プライバシーポリシー',
              style: TextStyle(
                color: AppColors().textPrimary,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<String?>(
                  builder: (context) => const CommonWebviewPage(
                    title: 'プライバシーポリシー',
                    url: 'https://policies.google.com/privacy?hl=ja&fg=1',
                  ),
                  fullscreenDialog: true,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
