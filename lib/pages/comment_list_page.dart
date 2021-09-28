import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
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
      user {
        id
        name
        profile_image_url
      }
    }
  }
''';

class CommentListPage extends HookWidget {
  const CommentListPage({Key? key, required this.articleId}) : super(key: key);

  final String? articleId;

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

    return Scaffold(
      appBar: AppBar(title: const Text('CommentListPage')),
      body: (articleId == null)
          ? _buildEmptyBody()
          : _buildCommentsQuery(_refreshControllerNotifier.value, _refreshList),
    );
  }

  Widget _buildEmptyBody() {
    return const Text('最初のコメントを投稿しましょう');
  }

  Widget _buildCommentsQuery(RefreshController _refreshController,
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
          child: _buildListView(comments),
        );
      },
    );
  }

  ListView _buildListView(List<Comment> comments) {
    return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: comments.length,
        itemBuilder: (BuildContext context, int index) {
          final comment = comments[index];
          return CommentListItem(comment: comment);
        });
  }
}
