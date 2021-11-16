import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/pages/my_profile/my_profile_page_logged_in.dart';
import 'package:labo_flutter/pages/my_profile/my_profile_page_not_logged_in.dart';
import 'package:labo_flutter/providers/user_change_notifier_provider.dart';

class MyProfilePage extends HookConsumerWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref
        .watch(userChangeNotifierProvider.select((value) => value.currentUser));
    return Scaffold(
      body: currentUser == null
          ? const MyProfilePageNotLoggedIn()
          : const MyProfilePageLoggedIn(),
    );
  }
}
