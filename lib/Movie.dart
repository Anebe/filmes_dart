
class Movie{
  final String id;
  final String title;
  final int year;
  final String urlPoster;

  const Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.urlPoster});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['#IMDB_ID'] ?? '',
      title: json['#TITLE'] ?? '',
      year: json['#YEAR'] ?? 0,
      urlPoster: json['#IMG_POSTER'] ?? '',
    );
  }
}