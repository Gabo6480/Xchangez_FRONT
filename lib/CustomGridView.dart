import 'package:Xchangez/CustomItemCard.dart';
import 'package:flutter/cupertino.dart';

class CustomGridView extends StatelessWidget {
  CustomGridView(this.future, {Key key, this.updateParent}) : super(key: key);

  final Future<dynamic> future;
  final Function updateParent;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double cardSize = width < 350 ? width * 0.9 / 2 : 175;
    double childAspectRatio = 0.58;
    double crossAxisCount = width * 0.9 / cardSize;
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none &&
                snapshot.hasData == null ||
            snapshot.data == null)
          return Text('Cargando...',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold));
        else if (snapshot.data.isNotEmpty)
          return GridView.builder(
            itemCount: snapshot.data.length, //numero de elementos
            scrollDirection: Axis.vertical, //Dirección de scroll
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount.truncate(),
                childAspectRatio: childAspectRatio),
            itemBuilder: (BuildContext context, int index) {
              return CustomItemCard(
                snapshot.data[index],
                updateParent: updateParent,
              ); //Lista de elementos
            },
          );
        else
          return Text('Aquí no hay nada...',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold));
      },
    );
  }
}
