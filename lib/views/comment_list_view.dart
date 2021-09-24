import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:labo_flutter/components/loading_indicator.dart';
import 'package:labo_flutter/models/comment/comment.dart';
import 'package:labo_flutter/utils/app_colors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

const String commentsQuery = '''
  query MyQuery(\$article_id: String!) {
    comments(where: {article_id: {_eq: \$article_id}}) {
      id
      text
      user {
        id
        name
        profile_image_url
      }
    }
  }
''';

class CommentListView extends HookWidget {
  const CommentListView({Key? key, required this.articleId}) : super(key: key);

  final String articleId;

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
      appBar: AppBar(title: const Text('CommentListView')),
      body: _buildBody(_refreshControllerNotifier.value, _refreshList),
    );
  }

  Widget _buildBody(RefreshController _refreshController,
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
          return _CommentListItem(comment: comment);
        });
  }
}

class _CommentListItem extends StatelessWidget {
  const _CommentListItem({Key? key, required this.comment}) : super(key: key);

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
          height: 88,
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(width: 1, color: Colors.grey))),
          child: Row(
            children: <Widget>[
              Column(
                children: [
                  SizedBox(
                    height: 44,
                    width: 44,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(44 / 2),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: comment.user?.profileImageUrl ?? '',
                        errorWidget: (context, url, dynamic error) =>
                            Image.asset('assets/images/default_article.png'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    comment.user?.name ?? '',
                    style: TextStyle(color: AppColors().textPrimary),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Flexible(
                child: Text(
                  'text: ${comment.text}',
                  style: TextStyle(color: AppColors().textPrimary),
                ),
              ),
            ],
          )),
    );
  }
}
