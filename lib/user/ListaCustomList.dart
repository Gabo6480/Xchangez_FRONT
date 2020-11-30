import 'package:Xchangez/model/Lista.dart';
import 'package:Xchangez/model/ObjetoLista.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListaCustomList extends StatelessWidget {
  ListaCustomList(
      {Key key, this.list, this.delete, this.edit, this.isOwner = false})
      : super(key: key);

  final Lista list;
  final Function(Lista list) delete;
  final Function(Lista list) edit;

  final bool isOwner;

  final List<Widget> tiles = List();

  @override
  Widget build(BuildContext context) {
    tiles.clear();
    for (var item in list.objetos) {
      tiles.add(_CustomListTile(object: item));
    }

    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              spreadRadius: 1,
              blurRadius: 2)
        ],
      ),
      child: Column(
        children: <Widget>[
              Row(
                children: (isOwner
                        ? <Widget>[
                            IconButton(
                              icon: Icon(Icons.delete),
                              color: Colors.redAccent,
                              onPressed: () => delete(list),
                            ),
                            IconButton(
                              icon: Icon(Icons.edit),
                              color: Colors.blueAccent,
                              onPressed: () => edit(list),
                            ),
                          ]
                        : <Widget>[SizedBox()]) +
                    [
                      Expanded(
                        child: SizedBox(),
                      ),
                      Icon(
                        list.esPublico ? Icons.public : Icons.lock,
                        color: Colors.black26,
                      )
                    ],
              ),
              Text(
                list.nombre,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Text(list.descripcion),
              Divider(
                color: Colors.black26,
                thickness: 1,
              )
            ] +
            tiles,
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  _CustomListTile({Key key, this.object}) : super(key: key);

  final ObjetoLista object;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(object.nombre),
      subtitle: Text(object.descripcion),
      trailing: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            color: !object.loBusca ? Colors.lightGreen : Colors.lightBlue,
            borderRadius: BorderRadius.circular(8)),
        child: Text(
          !object.loBusca ? "Tengo" : "Busco",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
