import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:labo_flutter/utils/app_colors.dart';

class SettingView extends StatelessWidget {
  const SettingView({Key? key}) : super(key: key);

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
          )
        ],
      ),
    );
  }
}
