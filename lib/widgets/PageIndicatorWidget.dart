import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ohmi/bloc/getNowPlayingBloc.dart';
import 'package:ohmi/modals/nowPlayingResponse.dart';
import 'package:ohmi/widgets/youtube_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../constant.dart' as Style;

class PageIndicatorWidget extends StatefulWidget {
  const PageIndicatorWidget({Key key}) : super(key: key);

  @override
  _PageIndicatorWidgetState createState() => _PageIndicatorWidgetState();
}

class _PageIndicatorWidgetState extends State<PageIndicatorWidget> {
  @override
  void initState() {
    nowPlayingBloc..getMovies();

    super.initState();
  }

  @override
  void dispose() {
    nowPlayingBloc..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildPageIndicator(context);
  }

  Widget _buildPageIndicator(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder<NowPlayingResponse>(
        stream: nowPlayingBloc.subject.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error.isEmpty && snapshot.data.error.length > 0) {
              return _buildErrorWidget(snapshot.data.error);
            } else {
              return _buildPageSlider(snapshot.data, context);
            }
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error);
          } else {
            return _buildLoadingWidget();
          }
        },
      ),
    );
  }

  Widget _buildPageSlider(NowPlayingResponse response, BuildContext context) {
    final controller = PageController(
      viewportFraction: 1,
      initialPage: 0,
      keepPage: true,
    );

    return Stack(
      children: [
        PageView.builder(
          // reverse: true,
          itemCount: response.nowPlayings.take(5).length,
          controller: controller,
          itemBuilder: (ctx, index) {
            return Stack(
              children: [
                Image.network(
                  'https://image.tmdb.org/t/p/original${response.nowPlayings[index].backPoster}',
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Style.ColorTheme.mainColor.withOpacity(0.1),
                        Style.ColorTheme.mainColor.withOpacity(0.9),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0, 0.9],
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  bottom: 0,
                  left: 0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) {
                            return YoutubePlayerScreen(
                              movieId: response.nowPlayings[index].id,
                            );
                          },
                        ),
                      );
                    },
                    child: Icon(
                      EvaIcons.playCircleOutline,
                      color: Style.ColorTheme.secondColor,
                      size: 40,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 10,
                  child: Column(
                    children: [
                      Text(
                        '${response.nowPlayings[index].title}',
                        style: TextStyle(
                            fontSize: 22,
                            color: Style.ColorTheme.titleColor,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        Positioned(
          bottom: 10,
          right: MediaQuery.of(context).size.width * 1 / 2.5,
          child: SmoothPageIndicator(
            controller: controller,
            count: 5,
            effect: WormEffect(
              spacing: 8.0,
              radius: 4.0,
              dotWidth: 8.0,
              dotHeight: 8,
              paintStyle: PaintingStyle.stroke,
              strokeWidth: 1.5,
              dotColor: Colors.grey,
              activeDotColor: Style.ColorTheme.secondColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
        ],
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
