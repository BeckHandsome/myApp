import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class WidgetVideo extends StatefulWidget {
  final String url;
  WidgetVideo({Key key, this.url}) : super(key: key);
  _WidgetVideoState createState() => _WidgetVideoState();
}

class _WidgetVideoState extends State<WidgetVideo> {
  String _url = '';
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _url = widget.url;
    //配置视频地址
    _videoPlayerController = VideoPlayerController.network(_url);
    _videoPlayerController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: _videoPlayerController.value.aspectRatio, //宽高比
      autoPlay: false, //自动播放
      looping: false, //循环播放
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    /**
      * 页面销毁时，视频播放器也销毁
      */
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: double.infinity,
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }
}
