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

  AsyncValue<AppUser?> editingAppUserValue = const AsyncValue.loading();
  AppUser? beforeEditingAppUser;

  Future<void> fetchMyAppUser() async {
    final userId = currentUser?.uid;
    if (userId == null) {
      editingAppUserValue = const AsyncValue.data(null);
      notifyListeners();
      return;
    }

    final myAppUser = await _appUserRepository.fetchAppUser(userId);
    editingAppUserValue = AsyncValue.data(myAppUser);
    notifyListeners();

    // 編集したかの判定用に保持
    beforeEditingAppUser = myAppUser;
  }

  bool isEditedProfile() {
    final editingAppUser = editingAppUserValue.data?.value;
    if (editingAppUser == null || beforeEditingAppUser == null) {
      return false;
    }

    final edited = editingAppUser != beforeEditingAppUser;
    return edited;
  }

  void setAppUserName(String newName) {
    final appUser = editingAppUserValue.data?.value;
    if (appUser != null) {
      final editedAppUser = appUser.copyWith(name: newName);
      editingAppUserValue = AsyncValue.data(editedAppUser);
      // リビルドでキーボードが閉じるのを防ぐため、notifyListenersは呼ばない
    }
  }

  Future<bool> updateAppUser() async {
    final editedAppUser = editingAppUserValue.data?.value;

    if (editedAppUser == null) {
      return false;
    }

    final didSuccess = await _appUserRepository.updateAppUser(editedAppUser);
    return didSuccess;
  }

  Future<bool> updateProfileImage() async {
    final currentAppUser = editingAppUserValue.data?.value;
    if (currentAppUser == null) {
      return false;
    }

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

    await EasyLoading.dismiss();
    final newAppUser = currentAppUser.copyWith(profileImageUrl: newImageUrl);
    editingAppUserValue = AsyncValue.data(newAppUser);
    notifyListeners();
    return true;
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
}
