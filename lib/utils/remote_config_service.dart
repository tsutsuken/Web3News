import 'dart:io';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

class RemoteConfigService {
  final _remoteConfig = RemoteConfig.instance;

  Future<void> initialize() async {
    try {
      // TODO: デフォルトをローカルで定義する
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(hours: 1),
        ),
      );
      await _remoteConfig.fetchAndActivate();
    } on Exception catch (e) {
      debugPrint(
          'RemoteConfigService initialize Exception. Cached or default values will be used');
    }
  }

  Future<int> minimumSupportAppBuildNumber() async {
    final keyMinimumSupportBuild = Platform.isAndroid
        ? 'minimum_support_app_build_number_android'
        : 'minimum_support_app_build_number_ios';
    final buildNumber = _remoteConfig.getInt(keyMinimumSupportBuild);
    debugPrint('minimumSupportAppBuildNumber: $buildNumber');
    return buildNumber;
  }

  Future<bool> isUnderMaintenance() async {
    final isUnderMaintenance = _remoteConfig.getBool('is_under_maintenance');
    debugPrint('isUnderMaintenance: $isUnderMaintenance');
    return isUnderMaintenance;
  }

  Future<String> maintenanceMessage() async {
    final maintenanceMessage = _remoteConfig.getString('maintenance_message');
    debugPrint('maintenanceMessage: $maintenanceMessage');
    return maintenanceMessage;
  }
}
