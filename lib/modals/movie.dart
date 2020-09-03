class Movie {
  final int id;
  final String title;
  final String overview;
  final String backPoster;
  final String poster;
  final String releaseDate;
  final double rating;

  Movie({
    this.id,
    this.title,
    this.overview,
    this.backPoster,
    this.poster,
    this.releaseDate,
    this.rating,
  });

  Movie.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        overview = json['overview'],
        backPoster = json['backdrop_path'],
        poster = json['poster_path'],
        releaseDate = json['release_date'],
        rating = json['vote_average'].toDouble();
}
