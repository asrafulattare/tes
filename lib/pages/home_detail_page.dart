import 'package:flutter/material.dart';
import 'package:flutter_catalog/models/catalog.dart';
import 'package:flutter_catalog/widgets/home_widgets/add_to_cart.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:video_player/video_player.dart';

class HomeDetailPage extends StatefulWidget {
  final Item catalog;

  const HomeDetailPage({Key key, @required this.catalog})
      : assert(catalog != null),
        super(key: key);

  @override
  State<HomeDetailPage> createState() => _HomeDetailPageState();
}

class _HomeDetailPageState extends State<HomeDetailPage> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // print(widget.catalog?.url);

    _controller = VideoPlayerController.network(widget.catalog?.url)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(
          () {},
        );
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: context.canvasColor),
      backgroundColor: context.canvasColor,
      bottomNavigationBar: Container(
        color: context.cardColor,
        child: ButtonBar(
          alignment: MainAxisAlignment.spaceBetween,
          buttonPadding: EdgeInsets.zero,
          children: [
            "\$${widget.catalog.price}".text.bold.xl4.red800.make(),
            // AddToCart(
            //   catalog: widget.catalog,
            // ).wh(120, 50),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
              child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            ),
          ],
        ).p32(),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Hero(
              tag: Key(widget.catalog.id.toString()),
              // child: Image.network(widget.catalog.image),
              child: Center(
                child: _controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      )
                    : Container(),
              ),
            ).h32(context),
            Expanded(
              child: VxArc(
                height: 30.0,
                arcType: VxArcType.CONVEY,
                edge: VxEdge.TOP,
                child: Container(
                  color: context.cardColor,
                  width: context.screenWidth,
                  child: Column(
                    children: [
                      widget.catalog.name.text.xl4
                          .color(context.accentColor)
                          .bold
                          .make(),
                      widget.catalog.desc.text
                          .textStyle(context.captionStyle)
                          .xl
                          .make()
                          .hide(),
                      10.heightBox,
                      "Dolor sea takimata ipsum sea eirmod aliquyam est. Eos ipsum voluptua eirmod elitr, no dolor dolor amet eirmod dolor labore dolores magna. Amet vero vero vero kasd, dolore sea sed sit invidunt nonumy est sit clita. Diam aliquyam amet tempor diam no aliquyam invidunt. Elitr lorem eirmod dolore clita. Rebum."
                          .text
                          .textStyle(context.captionStyle)
                          .make()
                          .p16()
                    ],
                  ).py64(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
