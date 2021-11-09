import 'package:flutter/material.dart';
import 'package:labo_flutter/utils/remote_config_service.dart';

Future<void> showMaintenanceDialogIfNeeded(BuildContext context) async {
  final remoteConfigService = RemoteConfigService();
  final isUnderMaintenance = await remoteConfigService.isUnderMaintenance();
  if (isUnderMaintenance) {
    final maintenanceMessage = await remoteConfigService.maintenanceMessage();
    _showMaintenanceDialog(context, maintenanceMessage);
  }
}

void _showMaintenanceDialog(BuildContext context, String contentText) {
  showDialog<void>(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: const Text('メンテナンス中です'),
        content: Text(contentText),
      );
    },
  );
}
