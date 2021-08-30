import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:labo_flutter/models/comment/comment.dart';

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
                pollInterval: const Duration(seconds: 10),
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

                return Flexible(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: comments.length,
                      itemBuilder: (BuildContext context, int index) {
                        final comment = comments[index];
                        return ListTile(
                          title: Text('text: ${comment.text}'),
                          trailing: const Icon(Icons.more_vert),
                          subtitle: Text('user_id: ${comment.userId}'),
                          onTap: () {},
                        );
                      }),
                );
              })
        ],
      ),
    );
  }
}
