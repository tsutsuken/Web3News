import 'package:labo_flutter/pages/favorite_article_list/favorite_article_list_page_notifier.dart';
import 'package:mockito/annotations.dart';

import 'favorite_article_list_page_notifier_test.mocks.dart';

@GenerateMocks([FavoriteArticleListPageNotifier])
void main() {
  var mock = MockFavoriteArticleListPageNotifier();
}
