import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/models/album/album.dart';
import 'package:labo_flutter/models/album/album_repository.dart';

final albumListProvider = FutureProvider<List<Album>>((ref) async {
  final albumRepository = ref.read(albumRepositoryProvider);
  return albumRepository.fetchList();
});

class HomeView extends HookWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final albumListAsyncValue = useProvider(albumListProvider);

    return albumListAsyncValue.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text(error.toString())),
      data: (albumList) {
        return RefreshIndicator(
          onRefresh: () async {
            print('onRefresh');
          },
          child: ListView.builder(
            itemCount: albumList.length,
            itemBuilder: (BuildContext context, int index) {
              final itemTitle =
                  albumList[index].title + albumList[index].id.toString();
              return _listItem(itemTitle, const Icon(Icons.settings));
            },
          ),
        );
      },
    );
  }

  Widget _listItem(String title, Icon icon) {
    return GestureDetector(
      onTap: () {
        print('onTap');
      },
      child: Container(
          height: 120,
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(width: 1, color: Colors.grey))),
          child: Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(0),
                child: Image.network('http://placehold.jp/200x200.png'),
              ),
              Flexible(
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ],
          )),
    );
  }
}
