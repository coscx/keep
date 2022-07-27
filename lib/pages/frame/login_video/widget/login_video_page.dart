import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';


class LoginVideosPage extends StatefulWidget {
  @override
  createState() => _LoginVideoPageState();
}

class _LoginVideoPageState extends State<LoginVideosPage> {
  /// 声明视频控制器
  late VideoPlayerController _controller;

  /// 视频地址
  final String videoUrl =
      "assets/images/keeps/ad_video.mp4";

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
      });
  }

  @override
  void dispose() {
    _controller.pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: <Widget>[
          Transform.scale(
            scale: _controller.value.aspectRatio /
                MediaQuery.of(context).size.aspectRatio,
            child: Center(
              child: Container(
                child: _controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      )
                    : Text("正在初始化"),
              ),
            ),
          ),
          Positioned(
            bottom: 26.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  child: Text("微信登录", style: TextStyle(fontSize: 18)),
                  onPressed: () {},
                ),
                ElevatedButton(
                  child: Text("手机号登录", style: TextStyle(fontSize: 18)),
                  onPressed: () {},
                ),

                Text(
                  "我已阅读并同意《服务协议》及《隐私政策》",

                )
              ],
            ),
          ),
          Positioned(
            top: 80.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "登录",

                ),

                Text(
                  "视频背景登录页面",

                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
