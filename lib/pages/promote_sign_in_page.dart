import 'package:flutter/material.dart';
import 'package:labo_flutter/pages/sign_in/sign_in_page.dart';
import 'package:labo_flutter/pages/sign_up/sign_up_page.dart';
import 'package:labo_flutter/utils/app_colors.dart';

class PromoteSignInPage extends StatelessWidget {
  const PromoteSignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: const ValueKey('CommentCreatePage'),
        direction: DismissDirection.vertical,
        confirmDismiss: (DismissDirection direction) async {
          Navigator.of(context).pop();
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('PromoteSignInPage'),
            leading: CloseButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: _buildNotLoggedInWidget(context),
        ));
  }

  // TODO: マイページとの共通ウィジェットとして書き出す
  Widget _buildNotLoggedInWidget(
    BuildContext context,
  ) {
    return Container(
      margin: const EdgeInsets.only(left: 40, right: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(
            Icons.person,
            size: 80,
          ),
          Text(
            '保存した記事を閲覧',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors().textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 44,
            child: ElevatedButton(
              onPressed: () async {
                final didSignUp = await Navigator.push(
                  context,
                  MaterialPageRoute<bool>(
                    builder: (context) => const SignUpPage(),
                    settings: const RouteSettings(name: 'SignUpPage'),
                  ),
                );

                if (didSignUp == true) {
                  Navigator.of(context).pop();
                }
              },
              child: const Text(
                '新規登録',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 44,
            child: ElevatedButton(
              onPressed: () async {
                final didLogin = await Navigator.push(
                  context,
                  MaterialPageRoute<bool>(
                    builder: (context) => const SignInPage(),
                    settings: const RouteSettings(name: 'SignInPage'),
                  ),
                );

                if (didLogin == true) {
                  Navigator.of(context).pop();
                }
              },
              style: ElevatedButton.styleFrom(primary: Colors.white),
              child: const Text(
                'ログイン',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
