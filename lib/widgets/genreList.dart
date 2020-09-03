import 'package:flutter/material.dart';
import 'package:ohmi/bloc/getMovieBloc.dart';

import 'package:ohmi/modals/genre.dart';

import 'package:ohmi/widgets/genreMoviesList.dart';

import '../constant.dart' as Style;

class GenreList extends StatefulWidget {
  final List<Genre> genres;
  GenreList({Key key, this.genres}) : super(key: key);

  @override
  _GenreListState createState() => _GenreListState(genres);
}

class _GenreListState extends State<GenreList>
    with SingleTickerProviderStateMixin {
  final List<Genre> genres;

  _GenreListState(this.genres);
  TabController tabController;
  var genreId = 28;
  @override
  void initState() {
    tabController = TabController(vsync: this, length: genres.length);
    tabController.addListener(() {
      movieBloc..drain();
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    // movieBloc..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: MediaQuery.of(context).size.width,
      child: DefaultTabController(
        length: genres.length,
        initialIndex: 0,
        child: Scaffold(
          backgroundColor: Style.ColorTheme.mainColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(55),
            child: AppBar(
              elevation: 0,
              backgroundColor: Style.ColorTheme.mainColor,
              bottom: TabBar(
                onTap: (id) {
                  genreId = genres[id].id;
                },
                // physics: NeverScrollableScrollPhysics(),
                controller: tabController,
                // labelPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
                indicatorColor: Style.ColorTheme.secondColor,
                isScrollable: true,
                tabs: genres
                    .map(
                      (e) => Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 11, horizontal: 10),
                        child: Text(
                          e.name,
                          style: TextStyle(
                            height: 1.2,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          body: TabBarView(
            controller: tabController,
            children: genres
                .map(
                  (genre) => GenreMoviesList(
                    genreId: genre.id,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
