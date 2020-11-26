import 'package:Xchangez/model/Lista.dart';
import 'package:Xchangez/model/ObjetoLista.dart';
import 'package:Xchangez/services/api.lista.dart';
import 'package:flutter/material.dart';

class ListaNewListForm extends StatefulWidget {
  ListaNewListForm({Key key, this.editLista}) : super(key: key);
  final Lista editLista;
  @override
  State<StatefulWidget> createState() => ListaNewListFormState();
}

class ListaNewListFormState extends State<ListaNewListForm> {
  Lista newLista;
  final _listFormKey = GlobalKey<FormState>();

  List<ObjetoLista> objetosLista = List();
  List<GlobalKey<_NewListObjState>> objetosListaKeys = List();
  List<Widget> objsListaWidgets = List();

  void save() {
    _listFormKey.currentState.save();
    objetosListaKeys.forEach((element) {
      element.currentState.save();
    });
    newLista.objetos = objetosLista;
    if (widget.editLista != null)
      ListaServices.edit(newLista);
    else
      ListaServices.create(newLista);
  }

  void addObjetoLista(ObjetoLista newObj) {
    objetosLista.add(newObj);
    objetosListaKeys.add(GlobalKey<_NewListObjState>());
    objsListaWidgets.add(_NewListObj(
      objetosLista.last,
      removeObjetoLista,
      key: objetosListaKeys.last,
    ));
    setState(() {});
  }

  void removeObjetoLista(ObjetoLista obj) {
    int index = objetosLista.indexOf(obj);
    objsListaWidgets.removeAt(index);
    objetosListaKeys.removeAt(index);
    objetosLista.removeAt(index);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    if (widget.editLista != null) {
      newLista = widget.editLista;
      widget.editLista.objetos.forEach((element) {
        addObjetoLista(element);
      });
    } else {
      newLista = Lista();
    }

    _descController = TextEditingController(text: newLista.descripcion)
      ..addListener(() {
        newLista.descripcion = _descController.text;
      });

    _nameController = TextEditingController(text: newLista.nombre)
      ..addListener(() {
        newLista.nombre = _nameController.text;
      });
  }

  var _descController;
  var _nameController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 450,
      child: Form(
        key: _listFormKey,
        child: ListView(
          children: [
                TextFormField(
                  controller: _nameController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 8),
                      labelText: "Nombre de Lista"),
                  onSaved: (input) => newLista.nombre = input,
                ),
                TextFormField(
                  controller: _descController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 8),
                      labelText: "Descripcion de la Lista"),
                  onSaved: (input) => newLista.descripcion = input,
                ),
                CheckboxListTile(
                  value: newLista.esPublico,
                  onChanged: (val) {
                    setState(() => newLista.esPublico = val);
                  },
                  title: Text("Publico"),
                ),
                Divider(
                  color: Colors.black26,
                  thickness: 1,
                ),
                IconButton(
                    icon: Icon(Icons.add),
                    color: Colors.greenAccent,
                    onPressed: () => addObjetoLista(ObjetoLista())),
                Divider(
                  color: Colors.black26,
                  thickness: 1,
                ),
              ] +
              objsListaWidgets,
        ),
      ),
    );
  }
}

class _NewListObj extends StatefulWidget {
  _NewListObj(this.objetoLista, this.remover, {Key key}) : super(key: key);

  final ObjetoLista objetoLista;
  final Function(ObjetoLista obj) remover;

  @override
  State<StatefulWidget> createState() => _NewListObjState();
}

class _NewListObjState extends State<_NewListObj> {
  final _formKey = GlobalKey<FormState>();

  void save() {
    _formKey.currentState.save();
  }

  @override
  void initState() {
    super.initState();
    _descController =
        TextEditingController(text: widget.objetoLista.descripcion)
          ..addListener(() {
            widget.objetoLista.descripcion = _descController.text;
          });

    _nameController = TextEditingController(text: widget.objetoLista.nombre)
      ..addListener(() {
        widget.objetoLista.nombre = _nameController.text;
      });
  }

  var _descController;
  var _nameController;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26, spreadRadius: 2, blurRadius: 4)
                ]),
            child: ListTile(
              title: TextFormField(
                controller: _nameController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 8),
                  labelText: "Nombre del Objeto",
                ),
                onSaved: (input) => widget.objetoLista.nombre = input,
              ),
              subtitle: TextFormField(
                controller: _descController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 8),
                    labelText: "Descripción del Objeto"),
                onSaved: (input) => widget.objetoLista.descripcion = input,
              ),
              leading: IconButton(
                icon: Icon(Icons.close),
                color: Colors.redAccent,
                onPressed: () => widget.remover(widget.objetoLista),
              ),
              trailing: InkWell(
                  onTap: () => setState(() {
                        widget.objetoLista.loBusca =
                            !widget.objetoLista.loBusca;
                      }),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Opacity(
                            opacity: widget.objetoLista.loBusca ? 1 : 0.25,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 6),
                              decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                "Busco",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            )),
                        Opacity(
                            opacity: !widget.objetoLista.loBusca ? 1 : 0.25,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 6),
                              decoration: BoxDecoration(
                                  color: Colors.lightGreen,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                "Tengo",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ))
                      ])),
            )));
  }
}
