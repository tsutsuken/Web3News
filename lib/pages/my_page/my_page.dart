import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/pages/my_page/my_page_logged_in.dart';
import 'package:labo_flutter/pages/my_page/my_page_not_logged_in.dart';
import 'package:labo_flutter/providers/user_change_notifier_provider.dart';

class MyPage extends HookConsumerWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _userChangeNotifier = ref.watch(userChangeNotifierProvider);
    return Scaffold(
      body: _userChangeNotifier.currentUser == null
          ? const MyPageNotLoggedIn()
          : const MyPageLoggedIn(),
    );
  }
}
