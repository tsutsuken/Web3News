import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:labo_flutter/models/comment/comment.dart';
import 'package:labo_flutter/utils/app_colors.dart';

const String commentsQuery = '''
  query MyQuery(\$article_id: String!) {
    comments(where: {article_id: {_eq: \$article_id}}) {
      id
      text
      user_id
    }
  }
''';

class CommentListView extends StatelessWidget {
  const CommentListView({Key? key, required this.articleId}) : super(key: key);

  final String articleId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CommentListView')),
      body: Column(
        children: [
          Query(
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

                if (result.isLoading) {
                  return const Text('Loading');
                }

                var comments = <Comment>[];
                final resultData = result.data;
                if (resultData != null) {
                  comments = CommentListResponse.fromJson(resultData).comments;
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    if (refetch != null) {
                      refetch();
                    }
                  },
                  child: Flexible(
                    child: _buildListView(comments),
                  ),
                );
              })
        ],
      ),
    );
  }

  ListView _buildListView(List<Comment> comments) {
    return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: comments.length,
        itemBuilder: (BuildContext context, int index) {
          final comment = comments[index];
          return ListTile(
            title: Text(
              'text: ${comment.text}',
              style: TextStyle(color: AppColors().textPrimary),
            ),
            trailing: const Icon(Icons.more_vert),
            subtitle: Text(
              'user_id: ${comment.userId}',
              style: TextStyle(color: AppColors().textSecondary),
            ),
            onTap: () {},
          );
        });
  }
}
