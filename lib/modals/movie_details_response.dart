import 'package:ohmi/modals/movie_details.dart';

class MovieDetailsResponse {
  final MovieDetails movieDetails;
  final String error;

  MovieDetailsResponse({
    this.movieDetails,
    this.error,
  }) {
    print('movie d construnct : ${this.movieDetails.id}');
  }

  MovieDetailsResponse.fromJson(Map<String, dynamic> json)
      : movieDetails = MovieDetails.fromJson(json),
        error = '';

  MovieDetailsResponse.fromError(String errorValue)
      : movieDetails = MovieDetails(
          id: null,
          adult: null,
          tagline: '',
          releaseDate: '',
          runtime: null,
          // spokenLanguage: null,
          genres: null,
        ),
        error = errorValue;
}
