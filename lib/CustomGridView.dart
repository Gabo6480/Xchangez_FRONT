import 'package:Xchangez/CustomItemCard.dart';
import 'package:flutter/cupertino.dart';

class CustomGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double cardSize = width < 350 ? width * 0.9 / 2 : 175;
    double childAspectRatio = 0.6;
    double crossAxisCount = width * 0.9 / cardSize;
    return GridView.builder(
      itemCount: 200, //numero de elementos
      scrollDirection: Axis.vertical, //Dirección de scroll
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount.truncate(),
          childAspectRatio: childAspectRatio),
      itemBuilder: (BuildContext context, int index) {
        return CustomItemCard(); //Lista de elementos
      },
    );
  }
}
