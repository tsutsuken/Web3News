import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/graphql_api_client.dart';

const String insertFavoriteMutation = '''
  mutation MyMutation(\$article_id: uuid!) {
    insert_favorites_one(object: {article_id: \$article_id}) {
      id
    }
  }
''';

const String deleteFavoriteMutation = '''
  mutation MyMutation(\$user_id: String!, \$article_id: uuid!) {
    delete_favorites(where: {user_id: {_eq: \$user_id}, article_id: {_eq: \$article_id}}) {
      returning {
        id
      }
    }
  }
''';

final favoriteRepositoryProvider = Provider.autoDispose<FavoriteRepositoryImpl>(
  (ref) {
    return FavoriteRepositoryImpl(ref.read);
  },
);

abstract class FavoriteRepository {
  Future<bool> addFavorite(String articleId);
  Future<bool> deleteFavorite(String articleId);
}

class FavoriteRepositoryImpl implements FavoriteRepository {
  FavoriteRepositoryImpl(this._reader);

  final Reader _reader;

  late final GraphQLClient _client = _reader(graphQLClientProvider).value;

  @override
  Future<bool> addFavorite(String articleId) async {
    debugPrint('addFavorite articleId: $articleId');
    var didSuccess = false;

    final result = await _client.mutate(
      MutationOptions(
        document: gql(insertFavoriteMutation),
        variables: <String, dynamic>{
          'article_id': articleId,
        },
      ),
    );

    if (result.hasException) {
      debugPrint('addFavorite exception: ${result.exception.toString()}');
    } else {
      didSuccess = true;
      debugPrint('addFavorite success');
    }

    return didSuccess;
  }

  @override
  Future<bool> deleteFavorite(String articleId) async {
    debugPrint('deleteFavorite articleId: $articleId');
    var didSuccess = false;
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    final result = await _client.mutate(
      MutationOptions(
        document: gql(deleteFavoriteMutation),
        variables: <String, dynamic>{
          'user_id': userId,
          'article_id': articleId,
        },
      ),
    );

    if (result.hasException) {
      debugPrint('deleteFavorite exception: ${result.exception.toString()}');
    } else {
      didSuccess = true;
      debugPrint('deleteFavorite success');
    }

    return didSuccess;
  }
}
