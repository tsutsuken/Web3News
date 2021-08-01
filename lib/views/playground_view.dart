import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/models/album/album.dart';
import 'package:labo_flutter/models/album/album_repository.dart';
import 'package:labo_flutter/views/playground_detail_view.dart';

const String query = '''
{
  launchesPast(limit: 10) {
    mission_name
    launch_date_local
    launch_site {
      site_name_long
    }
    links {
      article_link
      video_link
    }
  }
}
''';

final albumProvider = FutureProvider<Album>((ref) async {
  final albumRepository = ref.read(albumRepositoryProvider);
  return albumRepository.fetch();
});

class PlaygroundView extends HookWidget {
  const PlaygroundView({Key? key, required this.title, required this.color})
      : super(key: key);

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final albumAsyncValue = useProvider(albumProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(title,
                style: TextStyle(
                    color: color, fontSize: 36, fontWeight: FontWeight.bold)),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                      builder: (context) =>
                          PlaygroundDetailView(title: title, color: color)),
                );
              },
              child: const Text('次へ'),
            ),
            albumAsyncValue.when(
              data: (data) {
                final title = data.title;
                final userId = data.userId.toString();
                return Text('Title: $title,\nUserId: $userId');
              },
              loading: () {
                return const Text('Loading');
              },
              error: (e, stackTrace) {
                return Text(e.toString());
              },
            ),
            Query(
              options: QueryOptions(
                document: gql(query),
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

                final launches = result.data?['launchesPast'] as List<dynamic>;
                return Flexible(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: launches.length,
                      itemBuilder: (BuildContext context, int index) {
                        final dynamic launch = launches[index];
                        return ListTile(
                          title: Text('${launch["mission_name"]}'),
                          trailing: const Icon(Icons.more_vert),
                          subtitle: Text('${launch["launch_date_local"]}'),
                          onTap: () {},
                        );
                      }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
