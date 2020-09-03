import 'package:flutter/foundation.dart';
import 'package:ohmi/modals/movie_response.dart';
import 'package:ohmi/repository/repository.dart';
import 'package:rxdart/subjects.dart';

class MovieBloc {
  BehaviorSubject<MovieResponse> _subject = BehaviorSubject<MovieResponse>();
  MovieRepository repository = MovieRepository();

  getMovies(int id) async {
    final response = await repository.getMoviesByGenre(id);
    _subject.sink.add(response);
  }

  void drain() {
    _subject.value = null;
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    await _subject.close();
  }

  Stream<MovieResponse> get subject => _subject.stream;
}

final movieBloc = MovieBloc();
