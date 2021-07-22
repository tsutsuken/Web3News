import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/models/album.dart';
import 'package:labo_flutter/pages/project_detail_page.dart';
import 'package:http/http.dart' as http;

final albumProvider = FutureProvider<Album>((ref) async {
  final response =
  await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load album');
  }
});

class TabPage extends HookWidget {
  const TabPage({Key? key, required this.title, required this.color}) :
        super(key: key);

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final albumAsyncValue = useProvider(albumProvider);

    return Scaffold(
      backgroundColor: color,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
                title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold)
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                      builder: (context) =>
                          ProjectDetailPage(
                              title: title,
                              color: color)
                  ),
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