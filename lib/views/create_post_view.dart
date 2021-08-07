import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

const String insertPostMutation = '''
  mutation MyMutation(\$text: String!, \$user_id: String!, \$article_url: String!) {
    insert_posts_one(object: {text: \$text, user_id: \$user_id, article_url: \$article_url}) {
      id
    }
  }
''';

class CreatePostView extends HookWidget {
  const CreatePostView({Key? key, required this.articleUrl}) : super(key: key);

  final String articleUrl;

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
        appBar: AppBar(
          title: const Text('CreatePostView'),
        ),
        body: Column(children: [
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
                  'text': 'けしからん！',
                  'user_id': currentUser?.uid ?? '',
                  'article_url': articleUrl
                }),
                child: const Text('Postを追加'),
              );
            },
          )
        ]));
  }
}
