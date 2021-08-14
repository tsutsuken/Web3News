import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:labo_flutter/views/sign_in_view.dart';
import 'package:labo_flutter/views/sign_up_view.dart';

const String postsQuery = '''
{
  posts {
    id
    text
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

class MyPageView extends HookWidget {
  const MyPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    Future<void> getToken() async {
      final token = await currentUser?.getIdToken(true);
      print('token: $token');
    }

    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('currentUser: $currentUser'),
              const Text('MyPageView'),
              ElevatedButton(
                onPressed: getToken,
                child: const Text('トークンを取得'),
              ),
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
                  document: gql(postsQuery),
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
                            subtitle: Text('${post["id"]}'),
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
