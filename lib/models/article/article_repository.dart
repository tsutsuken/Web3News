import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:labo_flutter/models/article/article.dart';

final articleRepositoryProvider = Provider((ref) => ArticleRepository());

class ArticleRepository {
  Future<List<Article>> fetch() async {
    final apiKey = dotenv.env['SECRET_NEWS_API_KEY']!;
    final response = await http.get(
      Uri.parse('https://newsapi.org/v2/top-headlines?country=jp'),
      headers: {
        HttpHeaders.authorizationHeader: apiKey,
      },
    );
    if (response.statusCode == 200) {
      final articleListResponse = ArticleListResponse.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
      return articleListResponse.articles;
    } else {
      throw Exception('Failed to load article');
    }
  }
}
