import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:labo_flutter/components/comment_bottom_sheet.dart';
import 'package:labo_flutter/components/comment_list_item.dart';
import 'package:labo_flutter/components/loading_indicator.dart';
import 'package:labo_flutter/models/comment/comment.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

const String commentsQuery = '''
  query MyQuery(\$article_id: String!) {
    comments(where: {article_id: {_eq: \$article_id}}) {
      id
      text
      created_at
      user_id
      user {
        id
        name
        profile_image_url
      }
    }
  }
''';

const String deleteCommentMutation = '''
  mutation MyMutation(\$id: uuid!) {
    delete_comments_by_pk(id: \$id) {
      id
    }
  }
''';

class CommentListPage extends HookWidget {
  const CommentListPage({Key? key, required this.articleId}) : super(key: key);

  final String? articleId;

  Future<void> _onTapMenuButton(
      BuildContext context, GraphQLClient client, Comment comment) async {
    await showCommentBottomSheet(
      context,
      comment: comment,
      onTapDeleteContent: () async {
        final didSuccess = await _deleteComment(client, comment);

        // スナックバーを表示
        var message = '';
        if (didSuccess) {
          message = '削除しました';
        } else {
          message = 'エラーが発信しました。もう一度お試しください';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );

        // TODO: リストを更新
      },
      onTapReportContent: () {
        debugPrint('onTapReportContent');
      },
      onTapBlockUser: () {
        debugPrint('onTapBlockUser');
      },
    );
  }

  Future<bool> _deleteComment(GraphQLClient client, Comment comment) async {
    var didSuccess = false;

    final result = await client.mutate(
      MutationOptions(
        document: gql(deleteCommentMutation),
        variables: <String, dynamic>{
          'id': comment.id,
        },
      ),
    );
    if (result.hasException) {
      debugPrint('_deleteComment exception: ${result.exception.toString()}');
      didSuccess = false;
    } else {
      didSuccess = true;
    }

    return didSuccess;
  }

  @override
  Widget build(BuildContext context) {
    final _refreshControllerNotifier =
        useState<RefreshController>(RefreshController(initialRefresh: false));

    Future<void> _refreshList(VoidCallback? _refetch) async {
      _refreshControllerNotifier.value.refreshCompleted();
      if (_refetch != null) {
        _refetch();
      }
    }

    return GraphQLConsumer(
      builder: (GraphQLClient client) {
        return Scaffold(
          appBar: AppBar(title: const Text('CommentListPage')),
          body: (articleId == null)
              ? _buildEmptyBody()
              : _buildCommentsQuery(
                  _refreshControllerNotifier.value, client, _refreshList),
        );
      },
    );
  }

  Widget _buildEmptyBody() {
    return const Text('最初のコメントを投稿しましょう');
  }

  Widget _buildCommentsQuery(
      RefreshController _refreshController,
      GraphQLClient client,
      Future<void> Function(VoidCallback? _refetch) _refreshList) {
    return Query(
      options: QueryOptions(
        document: gql(commentsQuery),
        variables: <String, dynamic>{
          'article_id': articleId,
        },
      ),
      builder: (QueryResult result,
          {VoidCallback? refetch, FetchMore? fetchMore}) {
        if (result.hasException) {
          return Text(result.exception.toString());
        }

        if (result.isLoading && result.data == null) {
          return const LoadingIndicator();
        }

        var comments = <Comment>[];
        final resultData = result.data;
        if (resultData != null) {
          comments = CommentListResponse.fromJson(resultData).comments;
        }

        if (comments.isEmpty) {
          return _buildEmptyBody();
        }

        return SmartRefresher(
          controller: _refreshController,
          onRefresh: () async {
            await _refreshList(refetch);
          },
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: comments.length,
            itemBuilder: (BuildContext context, int index) {
              final comment = comments[index];
              return CommentListItem(
                comment: comment,
                onTapMenuButton: () async {
                  await _onTapMenuButton(context, client, comment);
                },
              );
            },
          ),
        );
      },
    );
  }
}
