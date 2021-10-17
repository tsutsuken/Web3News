import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final signUpPageNotifierProvider =
    ChangeNotifierProvider.autoDispose((ref) => SignUpPageNotifier());

class SignUpPageNotifier extends ChangeNotifier {
  SignUpPageNotifier();

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

  Future<void> signUpAndRefreshToken({
    required VoidCallback onSuccess,
    required Function(String errorMessage) onError,
  }) async {
    debugPrint('signUpAndRefreshToken');
    final errorMessage = await _signUp();
    if (errorMessage != null) {
      onError(errorMessage);
    }

    _waitTokenRefresh(
      onSuccess: () {
        onSuccess();
      },
      onError: () {
        onError('トークンの取得に失敗しました');
      },
    );
  }

  Future<String?> _signUp() async {
    debugPrint('_signUp');
    String? errorMessage;
    try {
      final _ = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return errorMessage;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        errorMessage = '推測されにくいパスワードを設定してください';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'このメールアドレスで作成されたアカウントがすでに存在します';
      }
      return errorMessage;
    }
  }

  void _waitTokenRefresh({
    required VoidCallback onSuccess,
    required VoidCallback onError,
  }) {
    debugPrint('_waitTokenRefresh');
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      onError();
    }

    // （Firebase Functionsでセットされる）トリガーを監視して、CustomClaimの反映を待ち、トークンを更新する
    final triggerRef =
        FirebaseFirestore.instance.collection('user_meta').doc(userId);
    triggerRef.snapshots().listen((documentSnapshot) {
      if (documentSnapshot.exists) {
        debugPrint('refresh idToken by trigger');
        // トークンを強制更新する
        FirebaseAuth.instance.currentUser?.getIdToken(true);
        onSuccess();
      } else {
        debugPrint('trigger not exists');
      }
    });
  }
}
