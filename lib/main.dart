import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_catalog/core/store.dart';
import 'package:flutter_catalog/pages/cart_page.dart';
import 'package:flutter_catalog/pages/player.dart';
import 'package:flutter_catalog/pages/welcome_screen.dart';
import 'package:flutter_catalog/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';
import 'pages/home_page.dart';
import 'widgets/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(VxState(store: MyStore(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.select): ActivateIntent(),
      },
      child: MaterialApp(
        themeMode: ThemeMode.system,
        theme: MyTheme.lightTheme(context),
        darkTheme: MyTheme.darkTheme(context),
        debugShowCheckedModeBanner: false,
        initialRoute: MyRoutes.welcomeRoute,
        routes: {
          "/": (context) => HomePage(),
          MyRoutes.homeRoute: (context) => HomePage(),
          MyRoutes.drawerRoute: (context) => Drawer(),
          MyRoutes.cartRoute: (context) => CartPage(),
          MyRoutes.playerRoute: (context) => VideoApp(),
          MyRoutes.welcomeRoute: (context) => WelcomeScreen(),
        },
      ),
    );
  }
}
