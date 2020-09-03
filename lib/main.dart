import 'package:flutter/material.dart';
import 'package:ohmi/constant.dart';
import 'package:ohmi/screens./movieDetailScreen.dart';
import 'package:ohmi/screens./moviesHomePageScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        accentColor: ColorTheme.mainColor,
      ),
      routes: {
        '/': (ctx) => MoviesHomepageScreen(),
        MovieDetailScreen.routeName: (ctx) => MovieDetailScreen(),
      },
    );
  }
}
