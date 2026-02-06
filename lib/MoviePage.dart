import 'package:filmes_dart/view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({super.key});

  @override
  State createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  late MovieViewModel _viewModel;
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _viewModel = MovieViewModel();
    _viewModel.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Filmes')),
      body: Column(
        children: [
          TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Buscar filme'),
            onSubmitted: _viewModel.search,
          ),
          if (_viewModel.is_loading) const CircularProgressIndicator(),

          if (_viewModel.error != null) Text(_viewModel.error!),

          Expanded(
            child: ListView.builder(
              itemCount: _viewModel.movies.length,
              itemBuilder: (_, i) {
                final movie = _viewModel.movies[i];

                return ListTile(leading: Image.network(movie.urlPoster, width: 50), title: Text(movie.title), subtitle: Text(movie.year.toString()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
