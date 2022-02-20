import 'package:flutter/material.dart';
import 'package:flutter_catalog/models/catalog.dart';
import 'package:flutter_catalog/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';

class CatalogHeader extends StatelessWidget {
  final Item catalog;

  const CatalogHeader({Key key, this.catalog}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          child:
              "Live TV ".text.xl5.bold.color(context.theme.accentColor).make(),
        ),
        "From Bangladesh ❤️".text.xl2.make(),
      ],
    );
  }
}
