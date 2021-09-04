import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/models/app_user/app_user.dart';
import 'package:labo_flutter/providers/user_change_notifier_provider.dart';

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

  @override
  Widget build(BuildContext context) {
    final _editProfileViewModel = useProvider(_editProfileViewModelProvider);
    final _userChangeNotifier = useProvider(userChangeNotifierProvider);
    final _formKey = GlobalKey<FormState>();

    useEffect(() {
      debugPrint('ken');
    }, const []);

    return Scaffold(
      appBar: AppBar(
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
                    textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                )),
                child: const Text('保存'),
              );
            },
          )
        ],
      ),
      body: Center(
          child: Container(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Query(
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
                  return TextFormField(
                    initialValue: appUser.name,
                    decoration: const InputDecoration(
                      labelText: 'ユーザ名',
                      hintText: 'ユーザ名を入力してください',
                    ),
                    onChanged: (value) {
                      context.read(_editProfileViewModelProvider).username =
                          value;
                    },
                  );
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}
