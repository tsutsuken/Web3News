import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:labo_flutter/models/app_user/app_user.dart';
import 'package:labo_flutter/models/app_user/app_user_repository.dart';
import 'package:labo_flutter/providers/user_change_notifier_provider.dart';

final editProfilePageNotifierProvider =
    ChangeNotifierProvider.autoDispose((ref) {
  final appUserRepository = ref.read(appUserRepositoryProvider);
  final currentUser = ref
      .watch(userChangeNotifierProvider.select((value) => value.currentUser));
  return EditProfilePageNotifier(appUserRepository, currentUser);
});

class EditProfilePageNotifier extends ChangeNotifier {
  EditProfilePageNotifier(this._appUserRepository, this.currentUser) {
    fetchMyAppUser();
  }

  final AppUserRepository _appUserRepository;
  final User? currentUser;

  AsyncValue<AppUser?> myAppUserValue = const AsyncValue.loading();
  String username = '';

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

  Future<bool> updateUsername() async {
    var didSuccess = false;

    final userId = currentUser?.uid;
    if (userId == null) {
      return didSuccess;
    }

    didSuccess = await _appUserRepository.updateAppUser(userId, username);
    return didSuccess;
  }

  Future<bool> updateProfileImage() async {
    final pickedImageFile = await _pickImageFromGallery();
    if (pickedImageFile == null) {
      return false;
    }

    final croppedImageFile = await _cropImage(pickedImageFile);
    if (croppedImageFile == null) {
      return false;
    }

    await EasyLoading.show(maskType: EasyLoadingMaskType.black);
    final newImageUrl = await _uploadImageToStorage(croppedImageFile);
    if (newImageUrl == null || newImageUrl.isEmpty) {
      return false;
    }

    final didSuccessUpdate = await _updateProfileImageUrl(newImageUrl);
    await EasyLoading.dismiss();

    return didSuccessUpdate;
  }

  Future<XFile?> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImageFile = await picker.pickImage(source: ImageSource.gallery);
    return pickedImageFile;
  }

  Future<File?> _cropImage(XFile imageFile) async {
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

  Future<String?> _uploadImageToStorage(File imageFile) async {
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

  Future<bool> _updateProfileImageUrl(String url) async {
    var didSuccess = false;
    final userId = currentUser?.uid;
    if (userId == null) {
      return didSuccess;
    }

    didSuccess =
        await _appUserRepository.updateAppUserProfileImageUrl(userId, url);
    return didSuccess;
  }
}
