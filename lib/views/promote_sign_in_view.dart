import 'package:flutter/material.dart';
import 'package:labo_flutter/views/sign_in_view.dart';
import 'package:labo_flutter/views/sign_up_view.dart';

class PromoteSignInView extends StatelessWidget {
  const PromoteSignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: const ValueKey('CommentCreateView'),
        direction: DismissDirection.vertical,
        confirmDismiss: (DismissDirection direction) async {
          Navigator.of(context).pop();
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('PromoteSignInView'),
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
          const Text(
            '保存した記事を閲覧',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 44,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                      builder: (context) => const SignUpView()),
                );
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                      builder: (context) => const SignInView()),
                );
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
