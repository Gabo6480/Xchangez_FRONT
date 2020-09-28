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
    double cardSize = 150;
    double childAspectRatio = 0.5;

    return CustomScaffold(GridView.builder(
      itemCount: 200, //numero de elementos
      scrollDirection: Axis.vertical, //Dirección de scroll
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: cardSize, childAspectRatio: childAspectRatio),
      itemBuilder: (BuildContext context, int index) {
        return CustomItemCard(
          cardWidth: cardSize,
        ); //Lista de elementos
      },
    ));
  }
}
