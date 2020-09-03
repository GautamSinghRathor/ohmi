import 'package:ohmi/modals/movie_response.dart';

import 'package:ohmi/repository/repository.dart';
import 'package:rxdart/subjects.dart';

class TopMovieBloc {
  BehaviorSubject<MovieResponse> _subject = BehaviorSubject<MovieResponse>();
  MovieRepository repository = MovieRepository();

  Future<void> getTopMovies() async {
    final response = await repository.getTopMovies();
    _subject.sink.add(response);
  }

  void dispose() async {
    await _subject.close();
  }

  Stream<MovieResponse> get subject => _subject.stream;
}

final topMovieBloc = TopMovieBloc();
