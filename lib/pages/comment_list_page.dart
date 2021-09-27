import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:labo_flutter/components/loading_indicator.dart';
import 'package:labo_flutter/models/comment/comment.dart';
import 'package:labo_flutter/utils/app_colors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:timeago/timeago.dart' as timeago;

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
          return _CommentListItem(comment: comment);
        });
  }
}

class _CommentListItem extends StatelessWidget {
  const _CommentListItem({Key? key, required this.comment}) : super(key: key);

  final Comment comment;

  // TODO: 共通クラスで書く
  String timeagoString(String timeString) {
    final time = DateTime.parse(timeString);
    final _timeagoString = timeago.format(time, locale: 'ja');
    return _timeagoString;
  }

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
                mainAxisAlignment: MainAxisAlignment.start,
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
                ],
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comment.user?.name ?? '',
                    style: TextStyle(color: AppColors().textPrimary),
                  ),
                  const SizedBox(height: 4),
                  Flexible(
                    child: Text(
                      'text: ${comment.text}',
                      style: TextStyle(color: AppColors().textPrimary),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    timeagoString(comment.createdAt),
                    style: TextStyle(color: AppColors().textPrimary),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
