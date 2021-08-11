import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

const String insertPostMutation = '''
  mutation MyMutation(\$text: String!, \$article_url: String!) {
    insert_posts_one(object: {text: \$text, article_url: \$article_url}) {
      id
    }
  }
''';

class CreatePostView extends HookWidget {
  const CreatePostView({Key? key, required this.articleUrl}) : super(key: key);

  final String articleUrl;

  @override
  Widget build(BuildContext context) {
    final editingTextNotifier = useState('');

    return Scaffold(
        appBar: AppBar(
          title: const Text('CreatePostView'),
        ),
        body: Column(children: [
          TextField(
            autofocus: true,
            maxLines: 10,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'コメントを書く',
            ),
            onChanged: (text) {
              editingTextNotifier.value = text;
            },
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
                  'text': editingTextNotifier.value,
                  'article_url': articleUrl
                }),
                child: const Text('Postを追加'),
              );
            },
          )
        ]));
  }
}
