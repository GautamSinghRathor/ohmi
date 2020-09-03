import 'package:ohmi/modals/genreResponse.dart';
import 'package:ohmi/repository/repository.dart';
import 'package:rxdart/subjects.dart';

class GenreBloc {
  BehaviorSubject<GenreResponse> _subject = BehaviorSubject<GenreResponse>();
  MovieRepository repository = MovieRepository();

  Future<void> getGenreList() async {
    final response = await repository.getGenreList();
 
    print(response.genres);
    _subject.sink.add(response);
  }

  void dispose() async {
    await _subject.close();
  }

  BehaviorSubject<GenreResponse> get subject => _subject;
}

final genreBloc = GenreBloc();
