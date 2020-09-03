import 'package:ohmi/modals/nowPlayingResponse.dart';
import 'package:ohmi/repository/repository.dart';
import 'package:rxdart/subjects.dart';

class NowPlayingBloc {
  BehaviorSubject<NowPlayingResponse> _subject =
      BehaviorSubject<NowPlayingResponse>();
  MovieRepository repository = MovieRepository();

  Future<void> getMovies() async {
    NowPlayingResponse response = await repository.getNowPlaying();
    // print(response);
    _subject.sink.add(response);
  }

  void dispose() async {
    await _subject.close();
  }

  BehaviorSubject<NowPlayingResponse> get subject => _subject;
}

final nowPlayingBloc = NowPlayingBloc();
