import 'package:flutter/material.dart';
import 'package:labo_flutter/pages/sign_in/sign_in_page.dart';
import 'package:labo_flutter/pages/sign_up_page.dart';
import 'package:labo_flutter/utils/app_colors.dart';

class MyProfilePageNotLoggedIn extends StatelessWidget {
  const MyProfilePageNotLoggedIn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                      builder: (context) => const SignUpPage()),
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
                      builder: (context) => const SignInPage()),
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
