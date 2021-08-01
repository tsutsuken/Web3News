import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/models/album/album.dart';
import 'package:labo_flutter/models/album/album_repository.dart';
import 'package:labo_flutter/views/playground_detail_view.dart';

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
          ],
        ),
      ),
    );
  }
}
