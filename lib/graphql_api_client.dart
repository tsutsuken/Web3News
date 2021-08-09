import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

ValueNotifier<GraphQLClient> clientFor({
  required String uri,
}) {
  final userid = FirebaseAuth.instance.currentUser?.uid ?? '';
  // final tokenId = FirebaseAuth.instance.currentUser?.getIdToken(false);
  final hasuraAdminSecret = dotenv.env['SECRET_HASURA_ADMIN_SECRET']!;
  final httpLink =
      HttpLink('https://labo-flutter.hasura.app/v1/graphql', defaultHeaders: {
    'x-hasura-admin-secret': hasuraAdminSecret,
    'X-Hasura-Role': 'user',
    'X-Hasura-User-Id': userid,
    // 'Authorization': 'Bearer $tokenId',
  });

  return ValueNotifier<GraphQLClient>(
    GraphQLClient(
      cache: GraphQLCache(store: HiveStore()),
      link: httpLink,
    ),
  );
}

// Future<QueryResult> query(
//   String query, {
//   Map<String, dynamic>? variables,
// }) async {
//   final QueryResult result = await clientFor.value.query(QueryOptions(
//     documentNode: gql(query),
//     variables: variables,
//   ));
//
//   if (result.exception != null) {
//     // エラー処理
//     print(result.exception);
//     for (final GraphQLError error in result.exception.graphqlErrors) {
//       print(error.message);
//     }
//   }
//
//   return result;
// }

/// Wraps the root application with the `graphql_flutter` client.
/// We use the cache for all state management.
class GraphQLApiClient extends StatelessWidget {
  GraphQLApiClient({
    Key? key,
    required this.child,
    required String uri,
  })  : client = clientFor(
          uri: uri,
        ),
        super(key: key);

  final Widget child;
  final ValueNotifier<GraphQLClient> client;

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: child,
    );
  }
}
