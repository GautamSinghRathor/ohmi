import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ohmi/widgets/PageIndicatorWidget.dart';
import 'package:ohmi/widgets/genreListWidget.dart';
import 'package:ohmi/widgets/popularPerson.dart';
import 'package:ohmi/widgets/topRatedMovies.dart';
import '../constant.dart' as Style;

class MoviesHomepageScreen extends StatelessWidget {
  static const routeName = '/movie-homepage-screen';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Style.ColorTheme.mainColor,
      drawer: Drawer(
        child: Stack(
          children: [
            Container(
              color: Style.ColorTheme.mainColor,
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Just Fansy Stuff',
                      style: TextStyle(
                        color: Style.ColorTheme.titleColor,
                        fontSize: 24,
                      ),
                    ),
                     Text(
                      'By Gautam Singh',
                      style: TextStyle(
                        color: Style.ColorTheme.titleColor,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Style.ColorTheme.mainColor,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
          icon: Icon(EvaIcons.menu2Outline),
        ),
        title: Text('Movie App'),
        actions: [
          IconButton(
            icon: Icon(EvaIcons.searchOutline),
            onPressed: () {},
          )
        ],
      ),
      body: ListView(
        children: [
          PageIndicatorWidget(),
          MovieGenre(),
          PopularPersons(),
          TopRatedMovies(),
        ],
      ),
    );
  }
}
