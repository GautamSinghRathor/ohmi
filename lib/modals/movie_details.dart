import 'package:ohmi/modals/genre.dart';

class MovieDetails {
  final int id;
  final bool adult;
  final List<Genre> genres;
  final String releaseDate;
  final int runtime;
  final int budget;
  // final List<Map<String, String>> spokenLanguage;
  final String tagline;

  MovieDetails({
    this.id,
    this.adult,
    this.genres,
    this.budget,
    this.releaseDate,
    this.runtime,
    // this.spokenLanguage,
    this.tagline,
  });

  MovieDetails.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        adult = json['adult'],
        releaseDate = json['release_date'],
        runtime = json['runtime'],
        genres = (json['genres'] as List)
            .map(
              (e) => Genre.fromJson(e),
            )
            .toList(),
        budget = json['budget'],
        // spokenLanguage =
        //     (json['spoken_language'] as List<Map<String, String>>).map(
        //   (e) => {
        //     'iso_639_1': e['iso_639_1'],
        //     'name': e['name'],
        //   },
        // ),

        tagline = json['tagline'];
}
