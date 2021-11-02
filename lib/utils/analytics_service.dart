import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final analyticsServiceProvider = Provider.autoDispose<AnalyticsService>(
  (ref) {
    return AnalyticsService();
  },
);

/// アナリティクスイベント
enum AnalyticsEvent {
  onTapCommentListButton,
  onTapAddCommentButton,
  onTapFavoriteButton,
}

class AnalyticsService {
  AnalyticsService();

  final analytics = FirebaseAnalytics();

  Future<void> sendEvent({
    required AnalyticsEvent event,
    Map<String, dynamic>? parameterMap,
  }) async {
    final eventName =
        event.toString().split('.')[1]; // enum型のeventからeventNameを抽出する
    debugPrint('sendEvent eventName: $eventName, parameterMap: $parameterMap');
    await analytics.logEvent(name: eventName, parameters: parameterMap);
  }
}
