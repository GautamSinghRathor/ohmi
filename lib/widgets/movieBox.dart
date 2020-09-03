import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ohmi/modals/movie.dart';
import 'package:ohmi/screens./movieDetailScreen.dart';
import '../constant.dart' as Style;

class MovieBox extends StatelessWidget {
  final String poster;
  final double rating;
  final String title;
  final Movie movie;
  const MovieBox({Key key, this.poster, this.title, this.rating, this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        height: 160,
        width: 100,
        margin: EdgeInsets.only(top: 3),
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Stack(
                  children: [
                    Container(
                      height: 130,
                      width: 95,
                      color: Style.ColorTheme.secondColor,
                      child: Icon(
                        EvaIcons.video,
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => MovieDetailScreen(
                              movie: movie,
                            ),
                          ),
                        );
                        // Navigator.pushNamed(
                        //   context,
                        //   MovieDetailScreen.routeName,
                        //   arguments: movie,
                        // );
                      },
                      child: ClipRRect(
                        // borderRadius: BorderRadius.circular(4),
                        child: Image.network(
                          poster,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Expanded(
              flex: 1,
              child: Text(
                title,
                style: TextStyle(
                  height: 1.5,
                  color: Style.ColorTheme.titleColor,
                ),
                maxLines: 1,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      rating.toString(),
                      style: TextStyle(color: Style.ColorTheme.titleColor),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    RatingBarIndicator(
                      rating: rating / 2,
                      itemBuilder: (context, index) => Icon(
                        EvaIcons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 10.0,
                      direction: Axis.horizontal,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
