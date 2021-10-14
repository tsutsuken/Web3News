import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/graphql_api_client.dart';

const String insertBlockMutation = '''
  mutation MyMutation(\$to_user_id: String!) {
    insert_blocks_one(object: {to_user_id: \$to_user_id}) {
      id
    }
  }
''';

final blockRepositoryProvider = Provider.autoDispose<BlockRepositoryImpl>(
  (ref) {
    final graphQLClientNotifier = ref.read(graphQLClientProvider);
    return BlockRepositoryImpl(graphQLClientNotifier.value);
  },
);

abstract class BlockRepository {
  Future<bool> blockUser(String userId);
}

class BlockRepositoryImpl implements BlockRepository {
  BlockRepositoryImpl(this._client);

  final GraphQLClient _client;

  @override
  Future<bool> blockUser(String userId) async {
    debugPrint('blockUser userId: $userId');
    var didSuccess = false;

    final result = await _client.mutate(
      MutationOptions(
        document: gql(insertBlockMutation),
        variables: <String, dynamic>{
          'to_user_id': userId,
        },
      ),
    );

    if (result.hasException) {
      debugPrint('blockUser exception: ${result.exception.toString()}');
      didSuccess = false;
    } else {
      didSuccess = true;
    }

    return didSuccess;
  }
}
