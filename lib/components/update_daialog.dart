import 'dart:io';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

const graphqlEndpoint = 'https://labo-flutter.hasura.app/v1/graphql';

Future<void> showUpdateDialogIfNeeded(BuildContext context) async {
  final shouldUpdate = await _shouldUpdateApp();
  if (shouldUpdate) {
    _showUpdateDialog(context);
  }
}

Future<bool> _shouldUpdateApp() async {
  final info = await PackageInfo.fromPlatform();
  final currentBuildNumber = int.parse(info.buildNumber);
  final minimumSupportBuildNumber = await _minimumSupportAppBuildNumber();
  debugPrint('currentBuild: $currentBuildNumber, '
      'minimumSupportBuild: $minimumSupportBuildNumber');
  final shouldUpdate = currentBuildNumber < minimumSupportBuildNumber;
  debugPrint('shouldUpdateApp: $shouldUpdate');
  return shouldUpdate;
}

Future<int> _minimumSupportAppBuildNumber() async {
  final remoteConfig = RemoteConfig.instance;
  try {
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );
    await remoteConfig.fetchAndActivate();
  } on Exception catch (exception) {
    debugPrint('exception: $exception');
    return 1; // すべてのビルドをサポート対象にする
  }

  final keyMinimumSupportBuild = Platform.isAndroid
      ? 'minimum_support_app_build_number_android'
      : 'minimum_support_app_build_number_ios';
  final buildNumber = remoteConfig.getInt(keyMinimumSupportBuild);
  return buildNumber;
}

void _showUpdateDialog(BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: const Text('アップデートのお知らせ'),
        content:
            const Text('各種パフォーマンスの改善および新機能を追加しました。最新バージョンへのアップデートをお願いします。'),
        actions: <Widget>[
          TextButton(
            child: const Text('アップデート'),
            onPressed: () async {
              await showAppStore();
            },
          ),
        ],
      );
    },
  );
}

Future<void> showAppStore() async {
  // TODO: ストアURLを差し替え
  final storeUrl = Platform.isAndroid
      ? 'https://play.google.com/store/apps/details?id=jp.naver.line.android&hl=ja'
      : 'https://apps.apple.com/jp/app/line/id443904275';
  if (await canLaunch(storeUrl)) {
    await launch(storeUrl);
  } else {
    debugPrint('Could not launch $storeUrl');
  }
}
