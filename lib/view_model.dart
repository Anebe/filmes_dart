
import 'package:filmes_dart/Movie.dart';
import 'package:filmes_dart/MovieApi.dart';
import 'package:flutter/cupertino.dart';

class MovieViewModel extends ChangeNotifier {
  final MovieApi _api = MovieApi();


  List<Movie> movies = [];
  bool is_loading = false;
  String? error;

  Future<List<Movie>?> search(String title) async {
    try {
      is_loading = true;
      error = null;
      notifyListeners();

      movies = await _api.getMovies(title);
    }catch (e) {
      error = 'Erro ao buscar filmes';
    }
    is_loading = false;
    notifyListeners();
  }
}