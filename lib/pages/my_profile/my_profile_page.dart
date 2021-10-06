import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/pages/my_profile/my_profile_page_logged_in.dart';
import 'package:labo_flutter/pages/my_profile/my_profile_page_not_logged_in.dart';
import 'package:labo_flutter/pages/my_profile/my_profile_page_notifier.dart';
import 'package:labo_flutter/providers/user_change_notifier_provider.dart';

class MyProfilePage extends HookConsumerWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _userChangeNotifier = ref.watch(userChangeNotifierProvider);
    final pageNotifier = ref.watch(myProfilePageNotifierProvider);
    return Scaffold(
      body: _userChangeNotifier.currentUser == null
          ? const MyProfilePageNotLoggedIn()
          : MyProfilePageLoggedIn(pageNotifier: pageNotifier),
    );
  }
}
