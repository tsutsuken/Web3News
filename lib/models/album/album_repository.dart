import 'dart:convert';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:labo_flutter/models/album/album.dart';

final albumRepositoryProvider = Provider((ref) => AlbumRepository());

class AlbumRepository {
  Future<Album> fetch() async {
    final response =
    await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

    if (response.statusCode == 200) {
      return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load album');
    }
  }
}
