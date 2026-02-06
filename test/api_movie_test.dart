

import 'package:filmes_dart/MovieApi.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async{
  final api = MovieApi();

  final movies = await api.getMovies('batman');

  if (movies.isNotEmpty) {
    print('Encontrou ${movies.length} filmes');
  }
  for (var movie in movies) {
    print(movie.title);
  }

}