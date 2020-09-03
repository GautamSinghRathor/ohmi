import 'package:flutter/foundation.dart';
import 'package:ohmi/modals/movie_details_response.dart';
import 'package:ohmi/repository/repository.dart';
import 'package:rxdart/subjects.dart';

class GetMovieBlocDetail {
  MovieRepository repository = MovieRepository();
  BehaviorSubject<MovieDetailsResponse> _subject =
      BehaviorSubject<MovieDetailsResponse>();

  Future<void> getMovieDetail(int id) async {
    final response = await repository.getMovieDetail(id);
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

  Stream<MovieDetailsResponse> get subject => _subject.stream;
}

final movieDetailBloc = GetMovieBlocDetail();
