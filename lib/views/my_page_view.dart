import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/views/sign_in_view.dart';
import 'package:labo_flutter/views/sign_up_view.dart';

const String myPostsQuery = '''
  query MyQuery(\$user_id: String!) {
    posts(where: {user_id: {_eq: \$user_id}}) {
      id
      text
      article_url
    }
  }
''';

const String insertPostMutation = '''
  mutation MyMutation(\$text: String!) {
    insert_posts_one(object: {text: \$text}) {
      id
    }
  }
''';

final _userNotifierProvider =
    StateNotifierProvider.autoDispose<_UserNotifier, User?>(
        (_) => _UserNotifier());

class _UserNotifier extends StateNotifier<User?> {
  _UserNotifier() : super(null);
  void listenAuthStateChanges() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      state = user;
    });
  }
}

class MyPageView extends HookWidget {
  const MyPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = useProvider(_userNotifierProvider);

    useEffect(() {
      context.read(_userNotifierProvider.notifier).listenAuthStateChanges();
    }, const []);

    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('currentUser: $currentUser'),
              const Text('MyPageView'),
              if (currentUser == null) ...[
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                            builder: (context) => const SignInView()),
                      );
                    },
                    child: const Text('サインイン')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                            builder: (context) => const SignUpView()),
                      );
                    },
                    child: const Text('新規登録')),
              ] else
                ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  child: const Text('サインアウト'),
                ),
              Mutation(
                options: MutationOptions(
                  document: gql(insertPostMutation),
                  onCompleted: (dynamic resultData) {
                    print('resultData: $resultData');
                  },
                  onError: (e) {
                    print('error: $e');
                  },
                ),
                builder: (
                  RunMutation runMutation,
                  QueryResult? result,
                ) {
                  return ElevatedButton(
                    onPressed: () => runMutation(<String, dynamic>{
                      'text': '本文',
                    }),
                    child: const Text('Postを追加'),
                  );
                },
              ),
              Query(
                options: QueryOptions(
                  document: gql(myPostsQuery),
                  variables: <String, dynamic>{
                    'user_id': currentUser?.uid ?? '',
                  },
                  pollInterval: const Duration(seconds: 10),
                ),
                builder: (QueryResult result,
                    {VoidCallback? refetch, FetchMore? fetchMore}) {
                  if (result.hasException) {
                    return Text(result.exception.toString());
                  }

                  if (result.isLoading) {
                    return const Text('Loading');
                  }

                  final posts = result.data?['posts'] as List<dynamic>;
                  return Flexible(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: posts.length,
                        itemBuilder: (BuildContext context, int index) {
                          final dynamic post = posts[index];
                          return ListTile(
                            title: Text('${post["text"]}'),
                            trailing: const Icon(Icons.more_vert),
                            subtitle: Text('${post["article_url"]}'),
                            onTap: () {},
                          );
                        }),
                  );
                },
              ),
            ]),
      ),
    );
  }
}
