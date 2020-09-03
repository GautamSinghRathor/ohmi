import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import '../constant.dart' as Style;
import 'package:ohmi/modals/youtube_response.dart';
import 'package:ohmi/bloc/get_youtube_bloc.dart';
import 'package:ohmi/widgets/loadingIndicator.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerScreen extends StatefulWidget {
  final movieId;
  YoutubePlayerScreen({
    Key key,
    this.movieId,
  }) : super(key: key);

  @override
  _YoutubePlayerScreenState createState() => _YoutubePlayerScreenState(movieId);
}

class _YoutubePlayerScreenState extends State<YoutubePlayerScreen> {
  final id;
  _YoutubePlayerScreenState(this.id);
  @override
  void dispose() {
    youtuebBloc..drain();
    super.dispose();
  }

  @override
  void initState() {
    youtuebBloc..getYoutubeVideos(id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.ColorTheme.mainColor,
      appBar: AppBar(
        backgroundColor: Style.ColorTheme.mainColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            EvaIcons.close,
            color: Colors.white,
          ),
        ),
      ),
      body: StreamBuilder<YoutubeResponse>(
        stream: youtuebBloc.subject,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error.isEmpty && snapshot.data.error.length > 0) {
              return _buildErrorWidget(snapshot.data.error);
            } else {
              if (snapshot.data.key == null) {
                return Text(
                  'No Videos',
                  style: TextStyle(
                    color: Style.ColorTheme.titleColor,
                  ),
                );
              }
              print('key : ${snapshot.data.key}');
              return _buildYoutubeWidget(snapshot.data.key);
            }
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error);
          } else {
            return LoadingIndicator();
          }
        },
      ),
    );
  }

  Widget _buildYoutubeWidget(String key) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: key,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        // mute: true,
      ),
    );
    return Center(
      child: Container(
        height: 250,
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.amber,
          progressColors: ProgressBarColors(
            playedColor: Colors.amber,
            handleColor: Colors.amberAccent,
          ),
          // onReady: () {
          //   _controller.addListener();
          // },
          onEnded: (metaData) {
            _controller.reset();
            Navigator.of(context).pop();
          },
        ),
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
