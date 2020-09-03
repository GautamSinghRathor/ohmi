class NowPlaying {
  final int id;
  final String backPoster;

  final String title;
  final String releaseDate;

  NowPlaying({
    this.id,
    this.releaseDate,
    this.backPoster,
    this.title,
  });

  NowPlaying.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        backPoster = json['backdrop_path'],
        releaseDate = json['release_date'],
        title = json['title'];
        
}
