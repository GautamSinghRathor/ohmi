import 'package:ohmi/modals/movie_response.dart';
import 'package:ohmi/repository/repository.dart';
import 'package:rxdart/subjects.dart';

class SimilarMovieBloc {
  MovieRepository _repository = MovieRepository();
  BehaviorSubject<MovieResponse> _subject = BehaviorSubject<MovieResponse>();

  Future<void> getSimilarMovies(int id) async {
    final response = await _repository.getSimilarMovies(id);
    _subject.sink.add(response);
  }

  void drain() {
    _subject.value = null;
  }

  void dispose() async {
    await _subject.drain();
    await _subject.close();
  }

  Stream<MovieResponse> get subject => _subject.stream;
}

final similarMovieBloc = SimilarMovieBloc();
