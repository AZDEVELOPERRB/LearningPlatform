import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// ignore: must_be_immutable
class RoyalYoutube extends StatefulWidget {
  String title,url;
  RoyalYoutube(this.title,this.url);
  @override
  _RoyalYoutubeState createState() => _RoyalYoutubeState();
}
class _RoyalYoutubeState extends State<RoyalYoutube> {
  YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.url),
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: false,
            ),
          ],
        ),
      ),
    );
  }
}
