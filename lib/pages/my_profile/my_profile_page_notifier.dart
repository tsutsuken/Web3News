import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/models/app_user/app_user.dart';
import 'package:labo_flutter/models/app_user/app_user_repository.dart';
import 'package:labo_flutter/models/comment/comment.dart';

final myProfilePageNotifierProvider = ChangeNotifierProvider.autoDispose(
  (ref) {
    final appUserRepository = ref.read(appUserRepositoryProvider);
    return MyProfilePageNotifier(appUserRepository);
  },
);

class MyProfilePageNotifier extends ChangeNotifier {
  MyProfilePageNotifier(this._appUserRepository) {
    fetchMyAppUser();
  }
  final AppUserRepository _appUserRepository;

  AsyncValue<List<Comment>> commentsValue = const AsyncValue.loading();
  AsyncValue<AppUser?> myAppUserValue = const AsyncValue.loading();

  Future<void> fetchMyAppUser() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      myAppUserValue = const AsyncValue.data(null);
      notifyListeners();
      return;
    }

    final myAppUser = await _appUserRepository.fetchAppUser(userId);
    myAppUserValue = AsyncValue.data(myAppUser);
    notifyListeners();
  }
}
