import 'package:ohmi/modals/youtube_response.dart';
import 'package:ohmi/repository/repository.dart';
import 'package:rxdart/subjects.dart';

class YoutubeVideoBloc {
  MovieRepository _repository = MovieRepository();
  BehaviorSubject<YoutubeResponse> _subject =
      BehaviorSubject<YoutubeResponse>();

  Future<YoutubeResponse> getYoutubeVideos(int id) async {
    final response = await _repository.getYoutubeVideos(id);
    _subject.sink.add(response);
  }

  void drain() {
    _subject.value = null;
  }

  Future<void> dispose() async {
    await _subject.drain();
    await _subject.close();
  }

  Stream<YoutubeResponse> get subject => _subject.stream;
}

final youtuebBloc = YoutubeVideoBloc();
