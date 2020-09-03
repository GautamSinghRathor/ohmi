import 'package:ohmi/modals/movie.dart';

class MovieResponse {
  final List<Movie> movies;
  final String error;

  MovieResponse({
    this.movies,
    this.error,
  });

  MovieResponse.fromJson(Map<String, dynamic> json)
      : movies = (json['results'] as List)
            .map(
              (data) => Movie.fromJson(data),
            )
            .toList(),
        error = '';

  MovieResponse.withError(String error)
      : movies = List(),
        error = error;
}
