import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final signInPageNotifierProvider =
    ChangeNotifierProvider.autoDispose((ref) => SignInPageNotifier());

class SignInPageNotifier extends ChangeNotifier {
  SignInPageNotifier();

  String email = '';
  String password = '';
  String message = '';
  bool shouldShowPassword = false;

  void setMessage(String value) {
    //エラーメッセージ設定
    message = value;
    notifyListeners();
  }

  void togglePasswordVisible() {
    shouldShowPassword = !shouldShowPassword;
    notifyListeners();
  }

  String? emptyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '入力してください';
    }
    return null;
  }

  Future<String?> signinWithEmailAndPassword() async {
    String? errorMessage;
    try {
      final _ = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return errorMessage;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      } else {
        errorMessage = '$e';
      }
      return errorMessage;
    }
  }
}
