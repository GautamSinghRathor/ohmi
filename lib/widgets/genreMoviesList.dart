import 'package:flutter/material.dart';
import 'package:ohmi/bloc/getMovieBloc.dart';

import 'package:ohmi/modals/movie_response.dart';
import 'package:ohmi/widgets/loadingIndicator.dart';
import 'package:ohmi/widgets/movieBox.dart';

class GenreMoviesList extends StatefulWidget {
  final genreId;

  GenreMoviesList({Key key, this.genreId}) : super(key: key);

  @override
  _GenreMoviesListState createState() => _GenreMoviesListState(genreId);
}

class _GenreMoviesListState extends State<GenreMoviesList> {
  final genreId;
  _GenreMoviesListState(this.genreId);
  @override
  void initState() {
    movieBloc.getMovies(genreId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponse>(
      stream: movieBloc.subject,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error.isEmpty && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          } else {
            if (snapshot.data.movies.length < 0) {
              return Text('No Movie Box');
            }
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) {
                return MovieBox(
                  poster:
                      'https://image.tmdb.org/t/p/w500${snapshot.data.movies[index].poster}',
                  rating: snapshot.data.movies[index].rating,
                  title: snapshot.data.movies[index].title,
                  movie: snapshot.data.movies[index],
                );
              },
              itemCount: snapshot.data.movies.length,
            );
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
}
