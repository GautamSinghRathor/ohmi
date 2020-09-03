import 'package:flutter/material.dart';

import 'package:ohmi/bloc/getTopMovies.dart';
import 'package:ohmi/modals/movie.dart';
import 'package:ohmi/modals/movie_response.dart';
import 'package:ohmi/widgets/loadingIndicator.dart';
import 'package:ohmi/widgets/movieBox.dart';
import '../constant.dart' as Style;

class TopRatedMovies extends StatefulWidget {
  TopRatedMovies({Key key}) : super(key: key);

  @override
  _TopRatedMoviesState createState() => _TopRatedMoviesState();
}

class _TopRatedMoviesState extends State<TopRatedMovies> {
  @override
  void initState() {
    topMovieBloc..getTopMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Top Movies of the week',
              style: TextStyle(
                color: Style.ColorTheme.titleColor.withOpacity(0.7),
                fontSize: 20,
              ),
            ),
          ),
          StreamBuilder<MovieResponse>(
            stream: topMovieBloc.subject,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.error.isEmpty &&
                    snapshot.data.error.length > 0) {
                  return _buildErrorWidget(snapshot.data.error);
                } else {
                  if (snapshot.data.movies.isEmpty) {
                    return Text('No Movies');
                  }
                  return _buildTopRatedWidget(snapshot.data);
                }
              } else if (snapshot.hasError) {
                return _buildErrorWidget(snapshot.error);
              } else {
                return LoadingIndicator();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTopRatedWidget(MovieResponse response) {
    List<Movie> movies = response.movies;
    if (movies.length == 0) {
      return Center(
        child: Text(
          'No Movies',
          style: TextStyle(color: Style.ColorTheme.titleColor),
        ),
      );
    }
    return Container(
      height: 176,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return MovieBox(
            poster: 'https://image.tmdb.org/t/p/w500${movies[index].poster}',
            rating: movies[index].rating,
            title: movies[index].title,
            movie: movies[index],
          );
        },
        itemCount: movies.length,
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
