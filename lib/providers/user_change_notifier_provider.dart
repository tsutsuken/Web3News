import 'package:cloud_firestore/cloud_firestore.dart';
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

      // トークン更新のための監視をする
      await listenTriggerForRefreshingIdToken(user);
    });
  }

  User? currentUser;

  // 新規登録時に、CustomClaimの反映を待ち、トークンを更新するための処理
  // （Firebase Functionsでセットする）トリガーを監視し、トークンを更新する
  Future<void> listenTriggerForRefreshingIdToken(User? user) async {
    // 未ログインの場合は、監視しない
    if (user == null) {
      return;
    }

    // すでにClaimがある場合は、監視しない
    final idTokenResult = await user.getIdTokenResult();
    final dynamic hasuraClaim =
        idTokenResult.claims?['https://hasura.io/jwt/claims'];
    if (hasuraClaim != null) {
      return;
    }

    // トリガーを監視する
    debugPrint('listenTriggerForRefreshingIdToken');
    final triggerRef =
        FirebaseFirestore.instance.collection('user_meta').doc(user.uid);
    triggerRef.snapshots().listen((documentSnapshot) {
      if (documentSnapshot.exists) {
        debugPrint('refresh idToken by trigger');
        FirebaseAuth.instance.currentUser?.getIdToken(true);
      } else {
        debugPrint('trigger not exists');
      }
    });
  }
}
