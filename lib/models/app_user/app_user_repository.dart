import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/graphql_api_client.dart';
import 'package:labo_flutter/models/app_user/app_user.dart';

const String appUserQuery = '''
query MyQuery(\$id: String!) {
  users_by_pk(id: \$id) {
    id
    name
    profile_image_url
  }
}
''';

final appUserRepositoryProvider = Provider.autoDispose<AppUserRepositoryImpl>(
  (ref) {
    final graphQLClientNotifier = ref.read(graphQLClientProvider);
    return AppUserRepositoryImpl(graphQLClientNotifier.value);
  },
);

abstract class AppUserRepository {
  Future<AppUser?> fetchAppUser(String userId);
}

class AppUserRepositoryImpl implements AppUserRepository {
  AppUserRepositoryImpl(this._client);

  final GraphQLClient _client;

  @override
  Future<AppUser?> fetchAppUser(String userId) async {
    debugPrint('fetchAppUser userId: $userId');
    try {
      final result = await _client.query(
        QueryOptions(
          document: gql(appUserQuery),
          variables: <String, dynamic>{
            'id': userId,
          },
          fetchPolicy: FetchPolicy.cacheAndNetwork,
        ),
      );

      if (result.hasException) {
        debugPrint('fetchAppUser exception: ${result.exception.toString()}');
        return null;
      }

      final resultData = result.data;
      if (resultData == null) {
        return null;
      }

      final appUser = AppUserResponse.fromJson(resultData).usersByPk;
      return appUser;
    } on Exception catch (e) {
      debugPrint('fetchAppUser: $e');
      return null;
    }
  }
}
