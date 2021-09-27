import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:labo_flutter/models/article/article.dart';
import 'package:labo_flutter/utils/app_colors.dart';

const String insertCommentMutation = '''
  mutation MyMutation(\$text: String!, \$article_id: String!) {
    insert_comments_one(object: {text: \$text, article_id: \$article_id}) {
      id
    }
  }
''';

const String insertArticleMutation = '''
  mutation MyMutation(\$url: String!) {
    insert_articles_one(object: {url: \$url}) {
      id
    }
  }
''';

class ResponseAddCommentAndArticle {
  const ResponseAddCommentAndArticle(
      {required this.didAddComment, required this.articleId});
  final bool didAddComment;
  final String? articleId;
}

class CommentCreatePage extends HookWidget {
  const CommentCreatePage(
      {Key? key, required this.articleId, required this.articleUrl})
      : super(key: key);

  final String? articleId;
  final String articleUrl;

  Future<ResponseAddCommentAndArticle> addCommentAndArticleIfNeeded(
      GraphQLClient client,
      String? _articleId,
      String _articleUrl,
      String _text) async {
    if (_articleId == null) {
      final newArticleId = await addArticle(client, _articleUrl);
      if (newArticleId == null) {
        return const ResponseAddCommentAndArticle(
            didAddComment: false, articleId: null);
      }

      final didAddComment = await addComment(client, newArticleId, _text);
      return ResponseAddCommentAndArticle(
          didAddComment: didAddComment, articleId: newArticleId);
    } else {
      // コメントを追加
      final didAddComment = await addComment(client, _articleId, _text);
      return ResponseAddCommentAndArticle(
          didAddComment: didAddComment, articleId: _articleId);
    }
  }

  Future<String?> addArticle(
      GraphQLClient client, String addingArticleUrl) async {
    Article? addedArticle;
    try {
      final result = await client.mutate(
        MutationOptions(
          document: gql(insertArticleMutation),
          variables: <String, dynamic>{
            'url': addingArticleUrl,
          },
        ),
      );

      final resultData = result.data;
      if (resultData != null) {
        addedArticle =
            InsertArticlesOneResponse.fromJson(resultData).insertArticlesOne;
      }
    } on Exception catch (e) {
      debugPrint('addArticle error: $e');
      return null;
    }

    return addedArticle?.id;
  }

  Future<bool> addComment(
      GraphQLClient client, String _articleId, String _text) async {
    var didAddComment = false;
    try {
      final _ = await client.mutate(
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
      title: const Text('CommentCreatePage'),
      actions: [
        TextButton(
          onPressed: () async {
            final response = await addCommentAndArticleIfNeeded(
                client, articleId, articleUrl, editingTextNotifier.value);
            debugPrint('addCommentAndArticle response: $response');
            if (response.didAddComment) {
              Navigator.of(context).pop<String?>(response.articleId);
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
