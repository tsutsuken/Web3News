import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

ValueNotifier<GraphQLClient> clientFor({
  required String uri,
  required String idToken,
}) {
  final userid = FirebaseAuth.instance.currentUser?.uid ?? '';
  final httpLink =
      HttpLink('https://labo-flutter.hasura.app/v1/graphql', defaultHeaders: {
    'Authorization': 'Bearer $idToken',
    'X-Hasura-Role': 'user',
    'X-Hasura-User-Id': userid,
  });

  return ValueNotifier<GraphQLClient>(
    GraphQLClient(
      cache: GraphQLCache(store: HiveStore()),
      link: httpLink,
    ),
  );
}

/// Wraps the root application with the `graphql_flutter` client.
/// We use the cache for all state management.
class GraphQLApiClient extends StatelessWidget {
  GraphQLApiClient({
    Key? key,
    required this.child,
    required String uri,
    required String idToken,
  })  : client = clientFor(
          uri: uri,
          idToken: idToken,
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
