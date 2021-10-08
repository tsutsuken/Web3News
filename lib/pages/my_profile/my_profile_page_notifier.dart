import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/models/app_user/app_user.dart';
import 'package:labo_flutter/models/app_user/app_user_repository.dart';
import 'package:labo_flutter/models/comment/comment.dart';
import 'package:labo_flutter/providers/user_change_notifier_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

final myProfilePageNotifierProvider = ChangeNotifierProvider.autoDispose(
  (ref) {
    final appUserRepository = ref.read(appUserRepositoryProvider);
    final currentUser = ref
        .watch(userChangeNotifierProvider.select((value) => value.currentUser));
    return MyProfilePageNotifier(appUserRepository, currentUser);
  },
);

class MyProfilePageNotifier extends ChangeNotifier {
  MyProfilePageNotifier(this._appUserRepository, this.currentUser) {
    fetchMyAppUser();
  }
  final AppUserRepository _appUserRepository;
  final User? currentUser;
  final RefreshController refreshController = RefreshController();

  AsyncValue<List<Comment>> commentsValue = const AsyncValue.loading();
  AsyncValue<AppUser?> myAppUserValue = const AsyncValue.loading();

  Future<void> fetchMyAppUser() async {
    final userId = currentUser?.uid;
    if (userId == null) {
      myAppUserValue = const AsyncValue.data(null);
      notifyListeners();
      return;
    }

    final myAppUser = await _appUserRepository.fetchAppUser(userId);
    myAppUserValue = AsyncValue.data(myAppUser);
    notifyListeners();
  }

  Future<void> onRefresh() async {
    await fetchMyAppUser();
    refreshController.refreshCompleted();
  }
}
