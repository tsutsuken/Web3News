import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:labo_flutter/utils/app_colors.dart';

const String insertCommentMutation = '''
  mutation MyMutation(\$text: String!, \$article_id: String!) {
    insert_comments_one(object: {text: \$text, article_id: \$article_id}) {
      id
    }
  }
''';

class CommentCreateView extends HookWidget {
  const CommentCreateView({Key? key, required this.articleId})
      : super(key: key);

  final String? articleId;

  Future<bool> addComment(
      GraphQLClient client, String _articleId, String _text) async {
    var didAddComment = false;
    try {
      final result = await client.mutate(
        MutationOptions(
          document: gql(insertCommentMutation),
          variables: <String, dynamic>{'text': _text, 'article_id': _articleId},
        ),
      );
      didAddComment = true;
    } on Exception catch (e) {
      debugPrint('addComment error: $e');
      didAddComment = false;
    }
    return didAddComment;
  }

  @override
  Widget build(BuildContext context) {
    final editingTextNotifier = useState('');

    return GraphQLConsumer(
      builder: (GraphQLClient client) {
        return Scaffold(
          appBar: _buildAppBar(context, editingTextNotifier, client),
          body: _buildBody(editingTextNotifier),
        );
      },
    );
  }

  AppBar _buildAppBar(BuildContext context,
      ValueNotifier<String> editingTextNotifier, GraphQLClient client) {
    return AppBar(
      title: const Text('CommentCreateView'),
      actions: [
        TextButton(
          onPressed: () async {
            if (articleId != null) {
              final didAddComment = await addComment(
                  client, articleId!, editingTextNotifier.value);

              if (didAddComment) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('コメントを投稿しました'),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('エラーが発生しました。もう一度お試しください'),
                  ),
                );
              }
            }
          },
          style: TextButton.styleFrom(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          child: const Text('保存'),
        )
      ],
    );
  }

  Column _buildBody(ValueNotifier<String> editingTextNotifier) {
    return Column(children: [
      TextField(
        autofocus: true,
        maxLines: 10,
        style: TextStyle(
          color: AppColors().textPrimary,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'コメントを書く',
        ),
        onChanged: (text) {
          editingTextNotifier.value = text;
        },
      ),
    ]);
  }
}
