import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/components/loading_indicator.dart';
import 'package:labo_flutter/models/app_user/app_user.dart';
import 'package:labo_flutter/pages/edit_profile/edit_profile_page_notifier.dart';
import 'package:labo_flutter/utils/app_colors.dart';

class EditProfilePage extends HookConsumerWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _pageNotifier = ref.watch(editProfilePageNotifierProvider);
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: _buildAppBar(context, _pageNotifier),
      body: _buildBody(_formKey, _pageNotifier, context),
    );
  }

  AppBar _buildAppBar(
      BuildContext context, EditProfilePageNotifier _pageNotifier) {
    return AppBar(
      title: const Text('プロフィール編集'),
      actions: [
        TextButton(
          onPressed: () async {
            await EasyLoading.show(maskType: EasyLoadingMaskType.black);
            final didSuccess = await _pageNotifier.updateAppUser();
            await EasyLoading.dismiss();

            if (didSuccess) {
              Navigator.of(context).pop<bool>(true);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('プロフィールを更新しました'),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('エラーが発生しました'),
                ),
              );
            }
          },
          style: TextButton.styleFrom(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          child: const Text('保存'),
        ),
      ],
    );
  }

  Center _buildBody(
    GlobalKey<FormState> _formKey,
    EditProfilePageNotifier _pageNotifier,
    BuildContext context,
  ) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(24),
        child: _pageNotifier.myAppUserValue.when(
          data: (appUser) {
            if (appUser == null) {
              return const Text('エラーが発生しました');
            }
            return _buildForm(_formKey, _pageNotifier, appUser, context);
          },
          loading: () {
            return const LoadingIndicator();
          },
          error: (error, stackTrace) {
            return Text('エラーが発生しました: $error');
          },
        ),
      ),
    );
  }

  Form _buildForm(
    GlobalKey<FormState> _formKey,
    EditProfilePageNotifier _pageNotifier,
    AppUser appUser,
    BuildContext context,
  ) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextButton(
            onPressed: () async {
              final didSuccess = await _pageNotifier.updateProfileImage();
              if (didSuccess == false) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('エラーが発生しました。もう一度お試しください'),
                  ),
                );
              }
            },
            child: Column(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(appUser.profileImageUrl)),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'プロフィール写真を変更',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          TextFormField(
            initialValue: appUser.name,
            style: TextStyle(
              color: AppColors().textPrimary,
            ),
            decoration: const InputDecoration(
              labelText: 'ユーザ名',
              hintText: 'ユーザ名を入力してください',
            ),
            onChanged: (value) {
              _pageNotifier.setAppUserName(value);
            },
          ),
        ],
      ),
    );
  }
}
