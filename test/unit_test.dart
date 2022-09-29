import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:labo_flutter/models/article/article.dart';
import 'package:labo_flutter/models/article/article_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'unit_test.mocks.dart';

@GenerateMocks([GraphQLClient])
void main() {
  late MockGraphQLClient _client;
  late ArticleRepository _articleRepository;

  setUp(() {
    _client = MockGraphQLClient();
    _articleRepository = ArticleRepositoryImpl(_client);
  });

  test(
    'test articleRepository',
    () async {
      when(_client.query<dynamic>(any))
          .thenAnswer((_) async => QueryResult.unexecuted);

      final articles = await _articleRepository.fetchPopularArticles();
      expect(
        articles,
        isA<List<Article>>().having((list) => list.length, 'length', 0),
      );
      verify(_client.query<dynamic>(any)).called(1);
    },
  );
}
