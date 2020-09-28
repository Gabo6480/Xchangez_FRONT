import 'dart:math';

import 'package:Xchangez/CustomItemCard.dart';
import 'package:Xchangez/scaffold/CustomScaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    //print(MediaQuery.of(context).size.width);
    double cardSize = 200;
    double childAspectRatio = 0.7;
    double crossAxisCount = MediaQuery.of(context).size.width * 0.9 / cardSize;

    return CustomScaffold(Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05),
        child: GridView.builder(
          itemCount: 200, //numero de elementos
          scrollDirection: Axis.vertical, //Dirección de scroll
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount.truncate(),
              childAspectRatio: childAspectRatio),
          itemBuilder: (BuildContext context, int index) {
            return CustomItemCard(); //Lista de elementos
          },
        )));
  }
}
