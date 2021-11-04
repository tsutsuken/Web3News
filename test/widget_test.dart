// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/pages/favorite_article_list/favorite_article_list_page.dart';
import 'package:labo_flutter/pages/favorite_article_list/favorite_article_list_page_notifier.dart';
import 'package:labo_flutter/pages/sign_in/sign_in_page.dart';
import 'package:mockito/mockito.dart';

import 'favorite_article_list_page_notifier_test.mocks.dart';

void main() {
  group('test widgets', () {
    testWidgets('test FavoriteArticleListPage', (WidgetTester tester) async {
      final mockFavoriteArticleListPageNotifier =
          MockFavoriteArticleListPageNotifier();
      when(mockFavoriteArticleListPageNotifier.favoritesValue)
          .thenReturn(const AsyncValue.loading());

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            favoriteArticleListPageNotifierProvider
                .overrideWithValue(mockFavoriteArticleListPageNotifier)
          ],
          child: const MaterialApp(
            home: FavoriteArticleListPage(),
          ),
        ),
      );
    });

    testWidgets('test SignInPage', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: SignInPage(),
          ),
        ),
      );

      expect(find.text('ログイン'), findsOneWidget);
      expect(find.text('新規登録'), findsNothing);
    });
  });
}
