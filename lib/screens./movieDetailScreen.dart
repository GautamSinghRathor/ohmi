import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ohmi/bloc/getMovieDetailBloc.dart';
import 'package:ohmi/bloc/similar_movie_bloc.dart';

import 'package:ohmi/modals/movie.dart';
import 'package:ohmi/modals/movie_details.dart';
import 'package:ohmi/modals/movie_details_response.dart';
import 'package:ohmi/modals/movie_response.dart';
import 'package:ohmi/widgets/cast.dart';
import 'package:ohmi/widgets/loadingIndicator.dart';
import 'package:ohmi/widgets/movieBox.dart';
import 'package:ohmi/widgets/youtube_screen.dart';

import '../constant.dart' as Style;

class MovieDetailScreen extends StatefulWidget {
  static const routeName = '/movie-detail-screen';
  final Movie movie;

  const MovieDetailScreen({Key key, this.movie}) : super(key: key);

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState(movie);
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  Movie movie;
  _MovieDetailScreenState(this.movie);
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  // }

  @override
  void initState() {
    print('movie id : ${movie.id}');
    movieDetailBloc..getMovieDetail(movie.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.ColorTheme.mainColor,
      appBar: AppBar(
        backgroundColor: Style.ColorTheme.mainColor,
        title: Text(
          'Movie Details',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DetailWidget(
              movie: movie,
            ),
          ],
        ),
      ),
    );
  }
}

class DetailWidget extends StatefulWidget {
  final movie;
  DetailWidget({
    Key key,
    this.movie,
  }) : super(key: key);

  @override
  _DetailWidgetState createState() => _DetailWidgetState(movie);
}

class _DetailWidgetState extends State<DetailWidget> {
  final movie;
  _DetailWidgetState(this.movie);
  @override
  void initState() {
    print('movie id : ${movie.id}');
    movieDetailBloc..getMovieDetail(movie.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieDetailsResponse>(
      stream: movieDetailBloc.subject,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error.isEmpty && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          } else {
            if (snapshot.data.movieDetails.id == null) {
              return Text(
                'No Movies',
                style: TextStyle(
                  color: Style.ColorTheme.titleColor,
                ),
              );
            }
            print('movieId : ${snapshot.data.movieDetails.id}');
            return _buildMovieDetailWidget(movie, snapshot.data.movieDetails);
          }
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return LoadingIndicator();
        }
      },
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Text(
        error,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildMovieDetailWidget(Movie movie, MovieDetails details) {
    print(details);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 210,
            decoration: BoxDecoration(
              color: Style.ColorTheme.secondColor,
              image: DecorationImage(
                image: NetworkImage(
                    'https://image.tmdb.org/t/p/w500${movie.backPoster}'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) {
                        return YoutubePlayerScreen(
                          movieId: movie.id,
                        );
                      },
                    ),
                  );
                },
                child: Icon(
                  EvaIcons.playCircle,
                  color: Colors.white.withOpacity(0.5),
                  size: 50,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${movie.title}',
                  style: TextStyle(
                    color: Style.ColorTheme.titleColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'TMDB',
                      style: TextStyle(
                        color: Style.ColorTheme.titleColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      movie.rating.toString(),
                      style: TextStyle(
                        color: Style.ColorTheme.secondColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            color: Style.ColorTheme.titleColor.withOpacity(0.6),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              details.tagline == null
                  ? SizedBox()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${details.tagline}',
                        style: TextStyle(
                          color: Style.ColorTheme.titleColor.withOpacity(0.9),
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        softWrap: true,
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${movie.overview}',
                  style: TextStyle(
                    color: Style.ColorTheme.titleColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                  softWrap: true,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Budget',
                          style: TextStyle(
                            fontSize: 18,
                            color: Style.ColorTheme.titleColor.withOpacity(0.5),
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          details.budget <= 0 ? '0' : '${details.budget}\$',
                          style: TextStyle(
                            fontSize: 14,
                            color: Style.ColorTheme.secondColor,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Timing',
                          style: TextStyle(
                            fontSize: 18,
                            color: Style.ColorTheme.titleColor.withOpacity(0.5),
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          details.runtime <= 0
                              ? '0'
                              : details.runtime.toString() + ' min',
                          style: TextStyle(
                            fontSize: 14,
                            color: Style.ColorTheme.secondColor,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Release Date',
                          style: TextStyle(
                            fontSize: 18,
                            color: Style.ColorTheme.titleColor.withOpacity(0.5),
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          details.releaseDate == '' ? '0' : details.releaseDate,
                          style: TextStyle(
                            fontSize: 14,
                            color: Style.ColorTheme.secondColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Genres',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Style.ColorTheme.titleColor.withOpacity(0.5),
                  ),
                ),
              ),
              Container(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: details.genres
                      .map(
                        (e) => Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 5,
                          ),
                          margin: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 5,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              e.name,
                              style: TextStyle(
                                color: Style.ColorTheme.titleColor
                                    .withOpacity(0.7),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Movie Star Cast',
                  style: TextStyle(
                    color: Style.ColorTheme.titleColor.withOpacity(0.8),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
          CastWidget(
            movieId: movie.id,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Similar Movies',
              style: TextStyle(
                color: Style.ColorTheme.titleColor.withOpacity(0.8),
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          SimilarMovies(
            movieId: movie.id,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class SimilarMovies extends StatefulWidget {
  final movieId;
  SimilarMovies({Key key, this.movieId}) : super(key: key);

  @override
  _SimilarMoviesState createState() => _SimilarMoviesState(movieId);
}

class _SimilarMoviesState extends State<SimilarMovies> {
  final movieId;
  _SimilarMoviesState(this.movieId);
  @override
  void initState() {
    similarMovieBloc..getSimilarMovies(movieId);
    super.initState();
  }

  @override
  void dispose() {
    similarMovieBloc..drain();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponse>(
      stream: similarMovieBloc.subject,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error.isEmpty && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          } else {
            if (snapshot.data.movies.length <= 0) {
              return Text(
                'No Similar Movies',
                style: TextStyle(
                  color: Colors.white,
                ),
              );
            }
            return _buildSimilarMoviesWidget(snapshot.data.movies);
          }
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return LoadingIndicator();
        }
      },
    );
  }

  Widget _buildSimilarMoviesWidget(List<Movie> similarMovies) {
    return Container(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
          return MovieBox(
            poster:
                'https://image.tmdb.org/t/p/w500${similarMovies[index].poster}',
            rating: similarMovies[index].rating,
            title: similarMovies[index].title,
            movie: similarMovies[index],
          );
        },
        itemCount: similarMovies.length,
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Text(
        error,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
