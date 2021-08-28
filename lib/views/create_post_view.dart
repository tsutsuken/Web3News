import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

const String insertPostMutation = '''
  mutation MyMutation(\$text: String!, \$article_id: String!) {
    insert_posts_one(object: {text: \$text, article_id: \$article_id}) {
      id
    }
  }
''';

class CreatePostView extends HookWidget {
  const CreatePostView({Key? key, required this.articleId}) : super(key: key);

  final String articleId;

  @override
  Widget build(BuildContext context) {
    final editingTextNotifier = useState('');

    return Scaffold(
        appBar: AppBar(
          title: const Text('CreatePostView'),
          actions: [
            Mutation(
              options: MutationOptions(
                document: gql(insertPostMutation),
                onCompleted: (dynamic resultData) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('コメントを投稿しました'),
                    ),
                  );
                },
                onError: (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$e'),
                    ),
                  );
                },
              ),
              builder: (
                RunMutation runMutation,
                QueryResult? result,
              ) {
                return ElevatedButton(
                  onPressed: () => runMutation(<String, dynamic>{
                    'text': editingTextNotifier.value,
                    'article_id': articleId
                  }),
                  style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
                  child: const Text('保存'),
                );
              },
            )
          ],
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
        ]));
  }
}
