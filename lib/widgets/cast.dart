import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ohmi/bloc/castBloc.dart';
import 'package:ohmi/modals/cast.dart';
import 'package:ohmi/modals/cast_response.dart';
import 'package:ohmi/widgets/loadingIndicator.dart';
import '../constant.dart' as Style;
class CastWidget extends StatefulWidget {
  final movieId;
  const CastWidget({Key key, this.movieId}) : super(key: key);

  @override
  _CastWidgetState createState() => _CastWidgetState(movieId);
}

class _CastWidgetState extends State<CastWidget> {
  final movieId;
  _CastWidgetState(this.movieId);
  @override
  void initState() {
    castBloc..getCast(movieId);
    super.initState();
  }

  @override
  void dispose() {
    castBloc..drain();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CastResponse>(
      stream: castBloc.subject,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error.isEmpty && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          } else {
            if (snapshot.data.cast.length <= 0) {
              return Text('No Movies');
            }
            return _buildCastList(snapshot.data.cast);
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

  Widget _buildCastList(List<Cast> casts) {
    return Container(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Stack(children: [
                  Container(
                    height: 80,
                    width: 80,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Style.ColorTheme.secondColor,
                    ),
                    child: Icon(EvaIcons.person),
                  ),
                  Container(
                    height: 80,
                    width: 80,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://image.tmdb.org/t/p/w200${casts[index].profilePath}',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ]),
                SizedBox(
                  height: 5,
                ),
                Text(
                  casts[index].name == null ? 'Actor Name' : casts[index].name,
                  style: TextStyle(
                    height: 1.5,
                    color: Style.ColorTheme.titleColor.withOpacity(0.9),
                  ),
                  softWrap: true,
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: 80,
                  child: Text(
                    casts[index].character == null
                        ? 'Known For'
                        : 'Playing as ${casts[index].character}',
                    style: TextStyle(
                      color: Style.ColorTheme.titleColor.withOpacity(0.7),
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: true,
                  ),
                )
              ],
            ),
          );
        },
        itemCount: 7,
      ),
    );
  }
}
