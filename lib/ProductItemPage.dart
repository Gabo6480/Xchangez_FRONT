import 'package:Xchangez/scaffold/CustomScaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductItemPage extends StatefulWidget {
  ProductItemPage({Key key}) : super(key: key);

  final Map<String, String> features = {
    "Marca": "Algo",
    "Modelo": "MK2",
    "Velocidad": "Bien rapido"
  };

  @override
  State<StatefulWidget> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItemPage> {
  List<Widget> _caracteristicas = List();

  @override
  void initState() {
    super.initState();
    widget.features.forEach((key, value) {
      _caracteristicas.add(ListTile(
        title: Text(key,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        trailing: Text(value),
      ));
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return CustomScaffold(ListView(children: [
      Container(
        width: double.infinity,
        margin: EdgeInsets.all(10),
        //height: 100,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(1.0, 0), //(x,y)
                blurRadius: 6.0,
              )
            ],
            borderRadius: BorderRadius.circular(20)),
        child: Wrap(
          children: [
            Container(
              width: 320,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text("Producto bien chidote asu bien perro",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 28)),
                      subtitle: Text(
                          "Publicado hace un pitero de tiempo alch ya ni me acuerdo jsjsjs",
                          style: TextStyle(fontSize: 12)),
                    ),
                    ListTile(title: Text("\$123123")),
                    ExpansionTile(
                        title: Text("Características",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        children: _caracteristicas),
                    ListTile(
                      title: Text("Descripción",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      subtitle: Text(
                          "TEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT"),
                    ),
                  ]),
            )
          ],
        ),
      ),
      Container(
          width: double.infinity,
          margin: EdgeInsets.all(10),
          //height: 100,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(1.0, 0), //(x,y)
                  blurRadius: 6.0,
                )
              ],
              borderRadius: BorderRadius.circular(20)),
          child: Text("Comentarios"))
    ]));
  }
}
