import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userChangeNotifierProvider =
    ChangeNotifierProvider((ref) => UserChangeNotifier());

class UserChangeNotifier extends ChangeNotifier {
  UserChangeNotifier() : super() {
    // ログイン状態の変化を検知
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      debugPrint(
          'UserChangeNotifier authStateChanged user: ${user.toString()}');
      currentUser = user;
      notifyListeners();
    });
  }

  User? currentUser;
}
