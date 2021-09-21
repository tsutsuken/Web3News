import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
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

const String updateUserProfileImageMutation = '''
mutation MyMutation(\$id: String!, \$profile_image_url: String!) {
  update_users_by_pk(pk_columns: {id: \$id}, _set: {profile_image_url: \$profile_image_url}) {
    id
    profile_image_url
  }
}
''';

const String myUserQuery = '''
query MyQuery(\$id: String!) {
  users_by_pk(id: \$id) {
    id
    name
    profile_image_url
  }
}
''';

class EditProfileView extends HookWidget {
  const EditProfileView({Key? key}) : super(key: key);

  Future<bool> updateProfileImage(GraphQLClient client) async {
    final pickedImageFile = await pickImageFromGallery();
    if (pickedImageFile == null) {
      return false;
    }

    final croppedImageFile = await cropImage(pickedImageFile);
    if (croppedImageFile == null) {
      return false;
    }

    final newImageUrl = await uploadImageToStorage(croppedImageFile);
    if (newImageUrl == null || newImageUrl.isEmpty) {
      return false;
    }

    final didSuccessUpdate = await updateProfileImageUrl(client, newImageUrl);
    return didSuccessUpdate;
  }

  Future<XFile?> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImageFile = await picker.pickImage(source: ImageSource.gallery);
    return pickedImageFile;
  }

  Future<File?> cropImage(XFile imageFile) async {
    final croppedImageFile = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      cropStyle: CropStyle.circle,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      maxWidth: 400,
      maxHeight: 400,
      androidUiSettings: const AndroidUiSettings(
        toolbarTitle: 'トリミング',
        cropFrameColor: Colors.transparent,
        showCropGrid: false,
        hideBottomControls: true,
      ),
      iosUiSettings: const IOSUiSettings(
        title: 'トリミング',
        rotateButtonsHidden: true,
        resetButtonHidden: true,
        aspectRatioPickerButtonHidden: true,
      ),
    );
    return croppedImageFile;
  }

  Future<String?> uploadImageToStorage(File imageFile) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null || userId.isEmpty) {
      return null;
    }

    final storage = FirebaseStorage.instance;
    final imageName = DateTime.now().microsecondsSinceEpoch;
    try {
      final snapshot = await storage
          .ref('profile/$userId/$imageName.jpg')
          .putFile(imageFile);
      final url = await snapshot.ref.getDownloadURL();
      return url;
    } on Exception catch (error) {
      debugPrint('error $error');
      return null;
    }
  }

  Future<bool> updateProfileImageUrl(GraphQLClient client, String url) async {
    var didSuccess = false;

    try {
      final result = await client.mutate(
        MutationOptions(
          document: gql(updateUserProfileImageMutation),
          variables: <String, dynamic>{
            'id': FirebaseAuth.instance.currentUser?.uid ?? '',
            'profile_image_url': url,
          },
        ),
      );
      debugPrint('updateProfileImageUrl success result.data: ${result.data}');
      didSuccess = true;
    } on Exception catch (e) {
      debugPrint('updateProfileImageUrl error: $e');
    }

    return didSuccess;
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
            return TextButton(
              onPressed: () => runMutation(
                <String, dynamic>{
                  'id': _userChangeNotifier.currentUser?.uid ?? '',
                  'name': _editProfileViewModel.username,
                },
              ),
              style: TextButton.styleFrom(
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
          GraphQLConsumer(
            builder: (GraphQLClient client) {
              return TextButton(
                onPressed: () async {
                  final didSuccess = await updateProfileImage(client);
                  final message =
                      didSuccess ? 'プロフィール写真を変更しました' : 'エラーが発生しました。もう一度お試しください';
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                    ),
                  );
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
              );
            },
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
