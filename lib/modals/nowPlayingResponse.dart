import 'package:ohmi/modals/nowPlaying.dart';

class NowPlayingResponse {
  final List<NowPlaying> nowPlayings;
  final String error;

  NowPlayingResponse({
    this.nowPlayings,
    this.error,
  });

  NowPlayingResponse.fromJson(Map<String, dynamic> json)
      : nowPlayings = (json['results'] as List)
            .map(
              (data) => NowPlaying.fromJson(data),
            )
            .toList(),
        error = '';

  NowPlayingResponse.withError(String error)
      : nowPlayings = List(),
        error = error;
}
