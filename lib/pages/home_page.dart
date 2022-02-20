import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:flutter_catalog/models/catalog.dart';
import 'package:flutter_catalog/widgets/drawer.dart';
import 'package:flutter_catalog/widgets/home_widgets/catalog_header.dart';
import 'package:flutter_catalog/widgets/home_widgets/catalog_list.dart';

import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //final url = "https://api.jsonbin.io/b/604dbddb683e7e079c4eefd3";
  var url = "https://api.npoint.io/a492d05ecb1684665cc6";

  var httpsUri =
      Uri(scheme: 'https', host: 'swiftcode.ga', path: '/catalog.json');

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await Future.delayed(Duration(seconds: 2));
    // final catalogJson =
    //     await rootBundle.loadString("assets/files/catalog.json");
    print(httpsUri);
    //final response = await http.get(Uri.parse(httpsUri.toString()));
    final response = await http.get(Uri.parse(url));
    final catalogJson = response.body;
    final decodedData = jsonDecode(catalogJson);
    var productsData = decodedData["products"];
    CatalogModel.items = List.from(productsData)
        .map<Item>((item) => Item.fromMap(item))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: context.canvasColor,
      body: RefreshIndicator(
        onRefresh: loadData,
        child: Container(
          padding: Vx.m32,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.only(top: 5)),
              CatalogHeader(),
              if (CatalogModel.items != null && CatalogModel.items.isNotEmpty)
                CatalogList().py8().expand()
              else
                CircularProgressIndicator().centered().expand(),
            ],
          ),
        ),
      ),
    );
  }
}
