import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

import 'package:flutter_catalog/models/catalog.dart';
import 'package:flutter_catalog/utils/routes.dart';

// ignore: must_be_immutable
class VideoApp extends StatefulWidget {
  final Item catalog;
  VideoApp({Key key, this.catalog}) : super(key: key);

  @override
  State<VideoApp> createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // print(widget.catalog?.url);

    _controller = VideoPlayerController.network(widget.catalog.url)
      ..setLooping(true)
      ..initialize().then((_) {
        _controller.value.isPlaying ? _controller.pause() : _controller.play();
        setLandscape();
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(
          () {},
        );
      });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      children: <Widget>[
        Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayerWidget(
                    controller: _controller,
                  ),
                )
              : Scaffold(
                  backgroundColor: context.canvasColor,
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CircularProgressIndicator().centered(),
                      10.heightBox,
                      TextButton(
                        child: "Try again".text.xl5.bold.center.make(),
                        onPressed: () => Navigator.pushReplacementNamed(
                            context, MyRoutes.homeRoute),
                      )
                    ],
                  ),
                ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    setAllOrientations();

    super.dispose();
  }

  Future setLandscape() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: []);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    await Wakelock.enable();
  }

  Future setAllOrientations() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);

    await Wakelock.disable();
  }

  Widget buildPlay() => _controller.value.isPlaying
      ? Container()
      : Container(
          color: Colors.black26,
          child: Center(
            child: Icon(
              _controller.play() != _controller.pause()
                  ? Icons.play_arrow
                  : Icons.push_pin,
              color: Colors.white,
              size: 70,
            ),
          ),
        );

  // @override
  // Widget build(BuildContext context) =>
  //     VideoPlayerFullscreenWidget(controller: _controller);
}

////////BasicOverlayWidget
class BasicOverlayWidget extends StatelessWidget {
  final VideoPlayerController controller;

  const BasicOverlayWidget({
    Key key,
    @required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () =>
            controller.value.isPlaying ? controller.pause() : controller.play(),
        child: Stack(
          children: <Widget>[
            buildPlay(),
          ],
        ),
      );

  Widget buildIndicator() => VideoProgressIndicator(
        controller,
        allowScrubbing: true,
      );

  Widget buildPlay() => controller.value.isPlaying
      ? Container()
      : Container(
          alignment: Alignment.center,
          color: Colors.black26,
          child: Icon(Icons.play_arrow, color: Colors.white, size: 80),
        );
}

///////VideoPlayerWidget
class VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController controller;

  const VideoPlayerWidget({
    Key key,
    @required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      controller != null && controller.value.isInitialized
          ? Container(alignment: Alignment.topCenter, child: buildVideo())
          : Container(
              height: 200,
              child: Center(child: CircularProgressIndicator()),
            );

  Widget buildVideo() => Stack(
        children: <Widget>[
          buildVideoPlayer(),
          Positioned.fill(child: BasicOverlayWidget(controller: controller)),
        ],
      );

  Widget buildVideoPlayer() => AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: VideoPlayer(controller),
      );
}
