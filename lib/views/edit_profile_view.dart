import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:labo_flutter/models/app_user/app_user.dart';
import 'package:labo_flutter/providers/user_change_notifier_provider.dart';
import 'package:labo_flutter/utils/app_colors.dart';

final _editProfileViewModelProvider =
    ChangeNotifierProvider.autoDispose((ref) => _EditProfileViewModel());

class _EditProfileViewModel extends ChangeNotifier {
  _EditProfileViewModel();

  String username = '';
}

const String updateUserMutation = '''
mutation MyMutation(\$id: String!, \$name: String!) {
  update_users_by_pk(pk_columns: {id: \$id}, _set: {name: \$name}) {
    id
  }
}
''';

const String myUserQuery = '''
query MyQuery(\$id: String!) {
  users_by_pk(id: \$id) {
    id
    name
  }
}
''';

class EditProfileView extends HookWidget {
  const EditProfileView({Key? key}) : super(key: key);

  Future<XFile?> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImageFile = await picker.pickImage(source: ImageSource.gallery);
    return pickedImageFile;
  }

  @override
  Widget build(BuildContext context) {
    final _editProfileViewModel = useProvider(_editProfileViewModelProvider);
    final _userChangeNotifier = useProvider(userChangeNotifierProvider);
    final _formKey = GlobalKey<FormState>();

    useEffect(() {
      debugPrint('ken');
    }, const []);

    return Scaffold(
      appBar: _buildAppBar(context, _userChangeNotifier, _editProfileViewModel),
      body: _buildBody(_formKey, _userChangeNotifier, context),
    );
  }

  AppBar _buildAppBar(
      BuildContext context,
      UserChangeNotifier _userChangeNotifier,
      _EditProfileViewModel _editProfileViewModel) {
    return AppBar(
      title: const Text('プロフィール編集'),
      actions: [
        Mutation(
          options: MutationOptions(
            document: gql(updateUserMutation),
            onCompleted: (dynamic resultData) {
              // Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('プロフィールを更新しました'),
                ),
              );
            },
            onError: (e) {
              debugPrint('e: $e');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$e'),
                ),
              );
            },
          ),
          builder: (
            RunMutation runMutation,
            QueryResult? result,
          ) {
            return ElevatedButton(
              onPressed: () => runMutation(<String, dynamic>{
                'id': _userChangeNotifier.currentUser?.uid ?? '',
                'name': _editProfileViewModel.username,
              }),
              style: ElevatedButton.styleFrom(
                primary: AppColors().backgroundPrimary,
                onPrimary: AppColors().textPrimary,
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('保存'),
            );
          },
        )
      ],
    );
  }

  Center _buildBody(GlobalKey<FormState> _formKey,
      UserChangeNotifier _userChangeNotifier, BuildContext context) {
    return Center(
        child: Container(
      padding: const EdgeInsets.all(24),
      child: Query(
        options: QueryOptions(
          document: gql(myUserQuery),
          variables: <String, dynamic>{
            'id': _userChangeNotifier.currentUser?.uid ?? '',
          },
        ),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }

          if (result.isLoading) {
            return const Text('Loading');
          }

          final resultData =
              result.data?['users_by_pk'] as Map<String, dynamic>?;
          if (resultData == null) {
            return const Text('No User');
          }

          final appUser = AppUser.fromJson(resultData);
          // return Text('name: ${user.name}, id: ${user.id}');
          return _buildForm(_formKey, appUser, context);
        },
      ),
    ));
  }

  Form _buildForm(
      GlobalKey<FormState> _formKey, AppUser appUser, BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextButton(
            onPressed: () async {
              final pickedImageFile = await pickImageFromGallery();
              if (pickedImageFile != null) {
                debugPrint('ttmm _image: ${File(pickedImageFile.path)}');
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
              context.read(_editProfileViewModelProvider).username = value;
            },
          ),
        ],
      ),
    );
  }
}
