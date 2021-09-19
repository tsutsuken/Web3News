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

  final String articleId;

  @override
  Widget build(BuildContext context) {
    final editingTextNotifier = useState('');

    return Scaffold(
        appBar: AppBar(
          title: const Text('CommentCreateView'),
          actions: [_buildAppBarActions(context, editingTextNotifier)],
        ),
        body: _buildBody(editingTextNotifier));
  }

  Mutation _buildAppBarActions(
      BuildContext context, ValueNotifier<String> editingTextNotifier) {
    return Mutation(
      options: MutationOptions(
        document: gql(insertCommentMutation),
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
            primary: AppColors().backgroundPrimary,
            onPrimary: AppColors().textPrimary,
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          child: const Text('保存'),
        );
      },
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
