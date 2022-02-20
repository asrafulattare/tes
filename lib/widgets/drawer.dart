import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/src/extensions/context_ext.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final imageUrl =
        "https://pbs.twimg.com/profile_images/1484558944400207875/kSN8Xjvx_400x400.jpg";
    return Drawer(
      backgroundColor: context.canvasColor,
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Color(0xfff5f5f5)),
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                margin: EdgeInsets.zero,
                accountName: Text("Asraful Attare"),
                accountEmail: Text("asrafulattare@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.home,
              ),
              title: Text(
                "Home",
                textScaleFactor: 1.2,
                style: TextStyle(),
              ),
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.profile_circled,
              ),
              title: TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    "Profile"
                        .text
                        .color(Colors.black)
                        .align(TextAlign.left)
                        .make()
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.mail,
              ),
              title: Text(
                "Email me",
                textScaleFactor: 1.2,
                style: TextStyle(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
