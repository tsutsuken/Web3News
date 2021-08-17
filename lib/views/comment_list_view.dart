import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

const String postsQuery = '''
  query MyQuery(\$article_url: String!) {
    posts(where: {article_url: {_eq: \$article_url}}) {
      id
      text
      user_id
    }
  }
''';

class CommentListView extends StatelessWidget {
  const CommentListView({Key? key, required this.articleUrl}) : super(key: key);

  final String articleUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CommentListView')),
      body: Column(
        children: [
          Query(
              options: QueryOptions(
                document: gql(postsQuery),
                variables: <String, dynamic>{
                  'article_url': articleUrl,
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

                final posts = result.data?['posts'] as List<dynamic>;
                return Flexible(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: posts.length,
                      itemBuilder: (BuildContext context, int index) {
                        final dynamic post = posts[index];
                        return ListTile(
                          title: Text('text: ${post["text"]}'),
                          trailing: const Icon(Icons.more_vert),
                          subtitle: Text('user_id: ${post["user_id"]}'),
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
