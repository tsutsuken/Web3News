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

const String updateUserMutation = '''
mutation MyMutation(\$id: String!, \$name: String!) {
  update_users_by_pk(pk_columns: {id: \$id}, _set: {name: \$name}) {
    id
  }
}
''';

const String updateUserProfileImageMutation = '''
mutation MyMutation(\$id: String!, \$profile_image_url: String!) {
  update_users_by_pk(pk_columns: {id: \$id}, _set: {profile_image_url: \$profile_image_url}) {
    id
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
  Future<bool> updateAppUser(String userId, String username);
  Future<bool> updateAppUserProfileImageUrl(String userId, String url);
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

  @override
  Future<bool> updateAppUser(String userId, String username) async {
    debugPrint('updateAppUser userId: $userId, username: $username');
    var didSuccess = false;

    try {
      final result = await _client.mutate(
        MutationOptions(
          document: gql(updateUserMutation),
          variables: <String, dynamic>{
            'id': userId,
            'name': username,
          },
        ),
      );

      if (result.hasException) {
        debugPrint('updateAppUser exception: ${result.exception.toString()}');
      } else {
        debugPrint('updateAppUser success');
        didSuccess = true;
      }
    } on Exception catch (e) {
      debugPrint('updateAppUser error: $e');
    }

    return didSuccess;
  }

  @override
  Future<bool> updateAppUserProfileImageUrl(String userId, String url) async {
    debugPrint('updateAppUserProfileImageUrl userId: $userId, url: $url');
    var didSuccess = false;

    try {
      final result = await _client.mutate(
        MutationOptions(
          document: gql(updateUserProfileImageMutation),
          variables: <String, dynamic>{
            'id': userId,
            'profile_image_url': url,
          },
        ),
      );

      if (result.hasException) {
        debugPrint(
            'updateAppUserProfileImageUrl exception: ${result.exception.toString()}');
      } else {
        debugPrint('updateAppUserProfileImageUrl success');
        didSuccess = true;
      }
    } on Exception catch (e) {
      debugPrint('_updateAppUserProfileImageUrl error: $e');
    }

    return didSuccess;
  }
}
