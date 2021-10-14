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
mutation MyMutation(\$id: String!, \$name: String!, \$profile_image_url: String!) {
  update_users_by_pk(pk_columns: {id: \$id}, _set: {name: \$name, profile_image_url: \$profile_image_url}) {
    id
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
  Future<bool> updateAppUser(AppUser newAppUser);
}

class AppUserRepositoryImpl implements AppUserRepository {
  AppUserRepositoryImpl(this._client);

  final GraphQLClient _client;

  @override
  Future<AppUser?> fetchAppUser(String userId) async {
    debugPrint('fetchAppUser userId: $userId');
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
  }

  @override
  Future<bool> updateAppUser(AppUser newAppUser) async {
    debugPrint('updateAppUser newAppUser: $newAppUser');
    var didSuccess = false;

    final result = await _client.mutate(
      MutationOptions(
        document: gql(updateUserMutation),
        variables: <String, dynamic>{
          'id': newAppUser.id,
          'name': newAppUser.name,
          'profile_image_url': newAppUser.profileImageUrl,
        },
      ),
    );

    if (result.hasException) {
      debugPrint('updateAppUser exception: ${result.exception.toString()}');
    } else {
      debugPrint('updateAppUser success');
      didSuccess = true;
    }

    return didSuccess;
  }
}
