
import 'dart:convert';

import 'package:filmes_dart/Movie.dart';
import 'package:http/http.dart' as http;
class MovieApi {
  static const String base_url = 'https://imdb.iamidiotareyoutoo.com/';
  
  final http.Client _client = http.Client();
  
  Future<List<Movie>> getMovies(String title) async {
    final uri = Uri.parse('$base_url/search?q=$title');

    final response = await _client.get(uri);

    if (response.statusCode != 200){
      throw Exception('Erro ao buscar filmes');
    }

    final data = jsonDecode(response.body);
    final results = data['description'] as List?;

    if (results == null) return [];

    return results.map((i) => Movie.fromJson(i)).toList();
  }
}