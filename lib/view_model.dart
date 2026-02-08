
import 'package:filmes_dart/Movie.dart';
import 'package:filmes_dart/MovieApi.dart';
import 'package:flutter/cupertino.dart';

class MovieViewModel extends ChangeNotifier {
  final MovieApi _api = MovieApi();


  List<Movie> _movies = [];
  List<Movie> movies = [];
  Set<int> years = {};
  int? selectedYear;
  bool isLoading = false;
  String? error;

  void search(String title) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      _movies = await _api.getMovies(title);
    }catch (e) {
      error = 'Erro ao buscar filmes';
    }

    movies = _movies;
    years.clear();
    years.addAll(_movies.map((m) => m.year));
    years = (years.toList()..sort()).toSet();
    isLoading = false;
    selectedYear = null;
    notifyListeners();
  }

  void filterYear(int? year){
    if (year != null){
      movies = _movies
          .where((m) => m.year == year)
          .toList();
      selectedYear = year;
      notifyListeners();
    }

  }
}