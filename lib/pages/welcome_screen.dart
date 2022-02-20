import 'package:flutter/material.dart';
import 'package:flutter_catalog/utils/routes.dart';
import 'dart:async';
import 'package:velocity_x/velocity_x.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  void navigationToNextPage() {
    Navigator.pushReplacementNamed(context, MyRoutes.homeRoute);
  }

  startSplashScreenTimer() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationToNextPage);
  }

  @override
  void initState() {
    super.initState();
    startSplashScreenTimer();
  }

  @override
  Widget build(BuildContext context) {
    return !context.isMobile
        ? Scaffold(
            backgroundColor: context.canvasColor,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Image.asset("assets/images/flutter_intro.png")
                      .box
                      .height(180)
                      .make(),
                ),
                "Live TV "
                    .text
                    .xl5
                    .bold
                    .center
                    .color(context.theme.colorScheme.secondary)
                    .make(),
                "ICC Communication".text.center.xl2.make(),
              ],
            ),
            bottomNavigationBar: BottomAppBar(
              color: Colors.transparent,
              child: "SOMI".text.center.bold.xl2.make().p12(),
              elevation: 0,
            ),
          )
        : Scaffold(
            backgroundColor: context.canvasColor,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Image.asset("assets/images/flutter_intro.png"),
                ),
                "Live TV "
                    .text
                    .xl5
                    .bold
                    .center
                    .color(context.theme.colorScheme.secondary)
                    .make(),
                "ICC Communication".text.center.xl2.make(),
              ],
            ),
            bottomNavigationBar: BottomAppBar(
              color: Colors.transparent,
              child: "SOMI".text.center.bold.xl2.make().p12(),
              elevation: 0,
            ),
          );
  }
}
