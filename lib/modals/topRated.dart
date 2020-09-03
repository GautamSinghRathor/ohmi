class TopRated {
  final int id;
  final String backPoster;
  final String poster;
  final String title;
  final String releaseDate;
  final String rating;

  TopRated({
    this.id,
    this.releaseDate,
    this.backPoster,
    this.poster,
    this.title,
    this.rating,
  });

  TopRated.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        backPoster = json['backdrop_path'],
        poster = json['poster_path'],
        releaseDate = json['release_date'],
        title = json['title'],
        rating = json['vote_average'];
}
