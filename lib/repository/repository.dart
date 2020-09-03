import 'package:dio/dio.dart';
import 'package:ohmi/modals/cast_response.dart';
import 'package:ohmi/modals/genreResponse.dart';
import 'package:ohmi/modals/movie_details_response.dart';
import 'package:ohmi/modals/movie_response.dart';
import 'package:ohmi/modals/nowPlayingResponse.dart';
import 'package:ohmi/modals/personResponse.dart';
import 'package:ohmi/modals/youtube_response.dart';

class MovieRepository {
  static const String _baseUrl = 'https://api.themoviedb.org/3';
  static const String _apiKey = 'a9190f8fdd6c311b17311fbcd210f815';
  // api endpoints
  final String moviesUrl = '/discover/movie';
  final String genreUrl = '/genre/movie/list';
  final String nowPlayingUrl = '/movie/now_playing';
  final String topRatedUrl = '/movie/top_rated';
  final String trendingUrl = '/trending/person/week';
  final String movieDetailsUrl = '/movie';

  final Dio dio = Dio();
  Future<YoutubeResponse> getYoutubeVideos(int id) async {
    final params = {
      'api_key': _apiKey,
      'language': 'en-US',
    };
    try {
      final response = await dio.get(
        _baseUrl + movieDetailsUrl + '/$id' + '/videos',
        queryParameters: params,
      );
      return YoutubeResponse.fromJson(response.data);
    } catch (e, stackTrace) {
      return YoutubeResponse.withError(
        e.toString(),
      );
    }
  }

  Future<MovieResponse> getSimilarMovies(int id) async {
    final params = {
      'api_key': _apiKey,
      'language': 'en-Us',
      'page': 1,
    };
    try {
      final response = await dio.get(
        _baseUrl + '$movieDetailsUrl' + '/$id' + '/similar',
        queryParameters: params,
      );
      print('similar movie: ${response.data}');
      return MovieResponse.fromJson(response.data);
    } catch (e, strackTrace) {
      return MovieResponse.withError(e.toString());
    }
  }

  Future<MovieResponse> getTopMovies() async {
    final params = {
      'language': 'en-US',
      'api_key': _apiKey,
    };

    try {
      final response =
          await dio.get('$_baseUrl$topRatedUrl', queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print(stackTrace);
      return MovieResponse.withError(error.toString());
    }
  }

  Future<MovieResponse> getMoviesByGenre(int id) async {
    final params = {
      'language': 'en-US',
      'api_key': _apiKey,
      'with_genres': id.toString(),
    };

    try {
      final response =
          await dio.get('$_baseUrl$moviesUrl', queryParameters: params);

      return MovieResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print(stackTrace);
      return MovieResponse.withError(error.toString());
    }
  }

  Future<GenreResponse> getGenreList() async {
    final params = {
      'language': 'en-US',
      'api_key': _apiKey,
    };

    try {
      final response =
          await dio.get('$_baseUrl$genreUrl', queryParameters: params);
      // print('gautam : $response');
      return GenreResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print(stackTrace);
      return GenreResponse.withError(error.toString());
    }
  }

  Future<NowPlayingResponse> getNowPlaying() async {
    final params = {
      'language': 'en-US',
      'api_key': _apiKey,
      'page': 1,
    };

    try {
      final response =
          await dio.get('$_baseUrl$nowPlayingUrl', queryParameters: params);
      // print('response data : ${response.data}');
      return NowPlayingResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print(stackTrace);
      return NowPlayingResponse.withError(error.toString());
    }
  }

  Future<PersonResponse> getPersons() async {
    final params = {
      'api_key': _apiKey,
    };

    try {
      final response =
          await dio.get('$_baseUrl$trendingUrl', queryParameters: params);

      return PersonResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print(stackTrace);
      return PersonResponse.withError(error.toString());
    }
  }

  Future<MovieDetailsResponse> getMovieDetail(int movieId) async {
    final params = {
      'api_key': _apiKey,
      'language': 'en-Us',
    };
    try {
      final response = await dio.get(
        '$_baseUrl$movieDetailsUrl/$movieId',
        queryParameters: params,
      );

      return MovieDetailsResponse.fromJson(response.data);
    } catch (error) {
      return MovieDetailsResponse.fromError(error.toString());
    }
  }

  Future<CastResponse> getCast(int movieId) async {
    final params = {
      'api_key': _apiKey,
    };
    try {
      print(
        _baseUrl + movieDetailsUrl + '/$movieId' + '/credits',
      );
      final response = await dio.get(
        _baseUrl + movieDetailsUrl + '/$movieId' + '/credits',
        queryParameters: params,
      );

      return CastResponse.fromJson(response.data);
    } catch (e) {
      return CastResponse.withError(e.toString());
    }
  }
}
