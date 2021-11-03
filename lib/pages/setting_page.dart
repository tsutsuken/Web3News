import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:labo_flutter/components/error_dialog.dart';
import 'package:labo_flutter/pages/common_webview_page.dart';
import 'package:labo_flutter/utils/app_colors.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  void showLogoutDialog(BuildContext context) {
    showDialog<void>(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: const Text('本当にログアウトしますか？'),
            actions: [
              TextButton(
                onPressed: () {
                  // ダイアログを閉じる
                  Navigator.pop(context);
                },
                child: const Text('キャンセル'),
              ),
              TextButton(
                onPressed: () async {
                  // ダイアログを閉じる
                  Navigator.pop(context);
                  await FirebaseAuth.instance.signOut();
                  // 設定画面を閉じる
                  Navigator.of(context).pop();
                },
                child: const Text('ログアウトする'),
              ),
            ],
          );
        });
  }

  void showDeleteUserDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          content: const Text('本当に退会しますか？'),
          actions: [
            TextButton(
              onPressed: () {
                // ダイアログを閉じる
                Navigator.pop(context);
              },
              child: const Text('キャンセル'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await EasyLoading.show(maskType: EasyLoadingMaskType.black);
                final errorMessage = await deleteUser();
                await EasyLoading.dismiss();
                if (errorMessage != null) {
                  // 失敗時
                  showErrorDialog(context, errorMessage);
                } else {
                  // 成功時
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('退会しました'),
                    ),
                  );
                }
              },
              child: const Text('退会する'),
            ),
          ],
        );
      },
    );
  }

  Future<String?> deleteUser() async {
    String? errorMessage;

    try {
      final _ = FirebaseAuth.instance.currentUser?.delete();
      errorMessage = null;
      debugPrint('deleteUser success');
    } on FirebaseAuthException catch (e) {
      debugPrint('deleteUser FirebaseAuthException: $e');
      if (e.code == 'requires-recent-login') {
        errorMessage = 'もう一度ログインする必要があります。ログアウトして再度ログインしてからお試しください。';
      } else {
        errorMessage = 'エラーが発生しました';
      }
    } on Exception catch (e) {
      debugPrint('deleteUser Exception: $e');
      errorMessage = 'エラーが発生しました';
    }

    return errorMessage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () {
              showLogoutDialog(context);
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
                    url:
                        'https://labo-flutter-frontend.vercel.app/policies/terms',
                  ),
                  settings: const RouteSettings(name: 'CommonWebviewPage'),
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
                    url:
                        'https://labo-flutter-frontend.vercel.app/policies/privacy',
                  ),
                  settings: const RouteSettings(name: 'CommonWebviewPage'),
                  fullscreenDialog: true,
                ),
              );
            },
          ),
          ListTile(
            onTap: () {
              showDeleteUserDialog(context);
            },
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: const Text(
              '退会する',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
