import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/pages/my_profile/my_profile_page_logged_in.dart';
import 'package:labo_flutter/pages/my_profile/my_profile_page_not_logged_in.dart';
import 'package:labo_flutter/pages/my_profile/my_profile_page_notifier.dart';

class MyProfilePage extends HookConsumerWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(myProfilePageNotifierProvider);
    return Scaffold(
      body: pageNotifier.currentUser == null
          ? const MyProfilePageNotLoggedIn()
          : MyProfilePageLoggedIn(pageNotifier: pageNotifier),
    );
  }
}
