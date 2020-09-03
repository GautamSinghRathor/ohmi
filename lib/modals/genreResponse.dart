import 'package:ohmi/modals/genre.dart';

class GenreResponse {
  final List<Genre> genres;
  final error;

  GenreResponse({
    this.genres,
    this.error,
  });

  GenreResponse.fromJson(Map<String, dynamic> json)
      : genres = (json['genres'] as List).map(
          (data) => Genre.fromJson(data),
        ).toList(),
        error = '';
  GenreResponse.withError(String error)
      : genres = List(),
        error = error;
}
