import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userChangeNotifierProvider =
    ChangeNotifierProvider((ref) => UserChangeNotifier());

class UserChangeNotifier extends ChangeNotifier {
  UserChangeNotifier() : super() {
    // ログイン状態の変化と、トークンの更新を検知
    FirebaseAuth.instance.idTokenChanges().listen((User? user) {
      debugPrint('UserChangeNotifier idTokenChanges');
      if (user == null) {
        idToken = '';
        notifyListeners();
      } else {
        user.getIdToken(false).then((value) {
          idToken = value;
          notifyListeners();
        });
      }

      currentUser = user;
      notifyListeners();
    });
  }

  User? currentUser;
  String idToken = '';
}

class UserState {
  UserState({
    this.currentUser,
    required this.idToken,
  });
  User? currentUser;
  String idToken;
}
