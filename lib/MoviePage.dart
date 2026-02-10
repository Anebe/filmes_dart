import 'package:flutter/material.dart';
import 'package:filmes_dart/view_model.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({super.key});

  @override
  State<MoviePage> createState() => _MoviePageState();
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
      appBar: AppBar(title: const Text('🎬 Filmes'), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// 🔍 Busca + filtro
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      onSubmitted: _viewModel.search,
                      decoration: InputDecoration(
                        hintText: 'Buscar filme...',
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  /// Dropdown ano
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        value: _viewModel.selectedYear,
                        hint: const Text('Ano'),
                        items: _viewModel.years.map((year) => DropdownMenuItem(value: year, child: Text(year.toString()))).toList(),
                        onChanged: _viewModel.filterYear,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// Loading
              if (_viewModel.isLoading)
                const Expanded(child: Center(child: CircularProgressIndicator()))
              else if (_viewModel.error != null)
                Expanded(
                  child: Center(
                    child: Text(_viewModel.error!, style: const TextStyle(color: Colors.red)),
                  ),
                )
              else
                Expanded(
                  child: ListView.separated(
                    itemCount: _viewModel.movies.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, i) {
                      final movie = _viewModel.movies[i];

                      return MovieTile(movie.urlPoster, movie.title, movie.year);
                    },
                  ),
                ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemCount: _viewModel.movies.length,
                  itemBuilder: (_, i) {
                    return MovieCard(image: _viewModel.movies[i].urlPoster, title: _viewModel.movies[i].title);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieTile extends StatelessWidget {
  final String image;
  final String title;
  final int year;

  const MovieTile(this.image, this.title, this.year, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(image, width: 60, fit: BoxFit.cover),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Ano: $year'),
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final String image;
  final String title;

  const MovieCard({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 350,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 4,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.network(image, fit: BoxFit.cover,width: double.infinity,
              height: double.infinity,),
            Positioned(bottom: 0, left: 0, right: 0,child: Container(color: Colors.black45, height: 50,),),
            Text(title, style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }
}
