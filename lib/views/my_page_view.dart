import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

const String postsQuery = '''
{
  posts {
    id
    text
  }
}
''';

const String insertPost = '''
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

    Future<UserCredential> createUserWithEmailAndPassword() async {
      try {
        final userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: 'barry.allen@example.com',
                password: 'SuperSecretPassword!');
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
        rethrow;
      }
    }

    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('currentUser: $currentUser'),
              const Text('MyPageView'),
              ElevatedButton(
                  onPressed: createUserWithEmailAndPassword,
                  child: const Text('サインアップ')),
              Mutation(
                options: MutationOptions(
                  document: gql(insertPost),
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
                  return FloatingActionButton(
                    onPressed: () => runMutation(<String, dynamic>{
                      'text': '本文',
                    }),
                    tooltip: 'Star',
                    child: const Icon(Icons.add),
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
