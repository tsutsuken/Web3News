import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userNotifierProvider =
    StateNotifierProvider.autoDispose<UserNotifier, User?>(
        (_) => UserNotifier());

class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null);
  void listenAuthStateChanges() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      state = user;
    });
  }
}
