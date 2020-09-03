import 'package:flutter/material.dart';
import 'package:ohmi/bloc/getGenreListBloc.dart';
import 'package:ohmi/modals/genreResponse.dart';
import 'package:ohmi/widgets/genreList.dart';
import 'package:ohmi/widgets/loadingIndicator.dart';
import '../constant.dart' as Style;

class MovieGenre extends StatefulWidget {
  const MovieGenre({Key key}) : super(key: key);

  @override
  _MovieGenreState createState() => _MovieGenreState();
}

class _MovieGenreState extends State<MovieGenre> {
  TabController tabController;
  @override
  void initState() {
    genreBloc..getGenreList();
    // tabController = TabController(vsync: t);
    super.initState();
  }

  @override
  void dispose() {
    genreBloc..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GenreResponse>(
        stream: genreBloc.subject.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error.isEmpty && snapshot.data.error.length > 0) {
              return _buildErrorWidget(snapshot.data.error);
            } else {
              return _buildGenreList(snapshot.data);
            }
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error);
          } else {
            return LoadingIndicator();
          }
        });
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

  Widget _buildGenreList(GenreResponse response) {
    if (response.genres.length <= 0) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'No Genre',
          style: TextStyle(color: Style.ColorTheme.titleColor),
        ),
      );
    }
    return GenreList(genres: response.genres);
  }
}
