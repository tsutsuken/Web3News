import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:labo_flutter/logger_http_client.dart';

// TODO: urlを共通化する
final graphQLClientProvider = Provider(
    (ref) => clientFor(uri: 'https://labo-flutter.hasura.app/v1/graphql'));

final authAuthorizationLink = AuthLink(
  headerKey: 'Authorization',
  getToken: () async {
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (idToken == null) {
      return null;
    } else {
      return 'Bearer $idToken';
    }
  },
);

final authRoleLink = AuthLink(
  headerKey: 'X-Hasura-Role',
  getToken: () {
    var role = '';
    if (FirebaseAuth.instance.currentUser != null) {
      role = 'user';
    } else {
      role = 'anonymous';
    }
    return role;
  },
);

final authUserIdLink = AuthLink(
  headerKey: 'X-Hasura-User-Id',
  getToken: () => FirebaseAuth.instance.currentUser?.uid,
);

final httpLink = HttpLink('https://labo-flutter.hasura.app/v1/graphql',
    httpClient: LoggerHttpClient(http.Client()));

ValueNotifier<GraphQLClient> clientFor({
  required String uri,
}) {
  return ValueNotifier<GraphQLClient>(
    GraphQLClient(
      cache: GraphQLCache(store: HiveStore()),
      link: Link.from(
          [authAuthorizationLink, authRoleLink, authUserIdLink, httpLink]),
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
      child: CacheProvider(
        child: child,
      ),
    );
  }
}
