import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/models/app_user/app_user.dart';
import 'package:labo_flutter/models/app_user/app_user_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'my_profile_page_notifier.freezed.dart';

final myProfilePageNotifierProvider = StateNotifierProvider.autoDispose<
    MyProfilePageNotifier, MyProfilePageState>(
  (ref) {
    return MyProfilePageNotifier(ref.read);
  },
);

@freezed
abstract class MyProfilePageState with _$MyProfilePageState {
  const factory MyProfilePageState({
    @Default(AsyncValue<AppUser?>.loading())
        AsyncValue<AppUser?> myAppUserValue,
  }) = _MyProfilePageState;
}

class MyProfilePageNotifier extends StateNotifier<MyProfilePageState> {
  MyProfilePageNotifier(this._reader) : super(const MyProfilePageState()) {
    fetchMyAppUser();
  }

  final Reader _reader;

  late final AppUserRepository _appUserRepository =
      _reader(appUserRepositoryProvider);
  final RefreshController refreshController = RefreshController();

  Future<void> fetchMyAppUser() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      state = state.copyWith(
        myAppUserValue: const AsyncValue.data(null),
      );
      return;
    }

    final myAppUser = await _appUserRepository.fetchAppUser(userId);
    state = state.copyWith(
      myAppUserValue: AsyncValue.data(myAppUser),
    );
  }

  Future<void> onRefresh() async {
    await fetchMyAppUser();
    refreshController.refreshCompleted();
  }
}
