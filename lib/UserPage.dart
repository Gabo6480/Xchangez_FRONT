import 'dart:math';
import 'dart:typed_data';

import 'package:Xchangez/model/Usuario.dart';
import 'package:Xchangez/scaffold/CustomScaffold.dart';
import 'package:Xchangez/services/api.lista.dart';
import 'package:Xchangez/services/api.services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'model/Lista.dart';
import 'model/ObjetoLista.dart';

class UserPage extends StatefulWidget {
  UserPage(this.userID, {Key key})
      : this.isLoggedUser = APIServices.isLoggedUserId(userID),
        super(key: key);

  final int userID;
  final bool isLoggedUser;

  @override
  State<StatefulWidget> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  Widget _floatingButton = SizedBox();

  final listFormKey = GlobalKey<_NewListFormState>();

  Usuario authUser;
  List<Widget> listas = List();
  void _getUser() async {
    authUser = await APIServices.getUser(widget.userID);

    List<Lista> _listas = await ListaServices.getAllByUserId(widget.userID);
    listas.clear();
    _listas.forEach((element) {
      listas.add(_CustomList(list: element));
    });

    setState(() {});
  }

  bool _showButton = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _showButton = widget.isLoggedUser;

    _getUser();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _tabController.addListener(() {
      ThemeData theme = Theme.of(context);

      switch (_tabController.index) {
        case 0:
          _floatingButton = FloatingActionButton(
              child: Icon(Icons.note_add_outlined),
              backgroundColor: theme.primaryColor,
              onPressed: () {
                // Add your onPressed code here!
              });
          setState(() {});
          break;
        case 1:
          _floatingButton = FloatingActionButton(
              child: Icon(Icons.post_add),
              onPressed: () {
                Alert(
                    title: "Crear nueva lista",
                    context: context,
                    type: AlertType.none,
                    content: _NewListForm(
                      key: listFormKey,
                    ),
                    buttons: [
                      DialogButton(
                          color: theme.primaryColor,
                          child: Text(
                            "Aceptar",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            listFormKey.currentState.save();
                            Navigator.pop(context);
                            _getUser();
                          }),
                      DialogButton(
                        color: Colors.redAccent,
                        child: Text(
                          "Cancelar",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () => Navigator.pop(context),
                      )
                    ]).show();
              });
          setState(() {});
          break;
        case 2:
          _floatingButton = SizedBox();
          setState(() {});
          break;
        default:
      }
    });
    _tabController.animateTo(1);
    _tabController.animateTo(0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    var mQuery = MediaQuery.of(context);

    double padding =
        min(250, mQuery.size.width * 0.2 - 100).clamp(0, double.maxFinite);

    double imageSize = max(100 + padding * 0.5, 150);

    double height = mQuery.size.height;
    double width = mQuery.size.width;

    return authUser != null
        ? CustomScaffold(
            ListView(children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: padding),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.black26, spreadRadius: 3, blurRadius: 5)
                  ]),
                  child: Column(children: [
                    Stack(children: [
                      Container(
                        alignment: Alignment.bottomCenter,
                        width: double.infinity,
                        height: 200 + padding,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(25),
                                bottomLeft: Radius.circular(25)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  spreadRadius: 3,
                                  blurRadius: 5)
                            ],
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(authUser.imagenPortada))),
                        child: Container(
                          alignment: Alignment.bottomRight,
                          width: imageSize,
                          height: imageSize,
                          transform: Matrix4.translationValues(0, 25, 0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 6),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    spreadRadius: 3,
                                    blurRadius: 5)
                              ],
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(authUser.imagenPerfil))),
                          child: widget.isLoggedUser
                              ? Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  child: IconButton(
                                      icon: Icon(Icons.camera_alt),
                                      onPressed: () async {
                                        FilePickerResult result =
                                            await FilePicker.platform.pickFiles(
                                                type: FileType.image);
                                        if (result != null) if (await APIServices
                                            .updateAvatar(
                                                result.files.single, 1))
                                          _getUser();
                                      }))
                              : SizedBox(),
                        ),
                      ),
                      widget.isLoggedUser
                          ? Positioned(
                              right: 8,
                              bottom: 8,
                              child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white60),
                                  child: IconButton(
                                      color: Colors.black87,
                                      icon: Icon(Icons.image),
                                      onPressed: () async {
                                        FilePickerResult result =
                                            await FilePicker.platform.pickFiles(
                                                type: FileType.image);
                                        if (result != null) if (await APIServices
                                            .updateAvatar(
                                                result.files.single, 2))
                                          _getUser();
                                      })))
                          : SizedBox()
                    ]),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      authUser.nombre + " " + authUser.apellido,
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    _UserScore(
                      score: authUser.valoracion,
                    ),
                    Divider(
                      color: Colors.black26,
                      thickness: 1,
                    ),
                    Container(
                        width: 800,
                        child: TabBar(
                          controller: _tabController,
                          labelColor: theme.primaryColor,
                          indicatorColor: theme.primaryColor,
                          unselectedLabelColor: Colors.black,
                          tabs: [
                            Tab(text: 'Publicaciónes'),
                            Tab(text: 'Gustos'),
                            Tab(text: 'Valoraciones')
                          ],
                        )),
                  ])),
              Container(
                  height: height - 116,
                  margin: EdgeInsets.symmetric(horizontal: width * 0.2),
                  child: TabBarView(controller: _tabController, children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text('Display Tab 1',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: ListView(
                          children: listas +
                              [
                                listas.isEmpty
                                    ? Text('Aquí no hay nada...',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold))
                                    : SizedBox()
                              ],
                        )),
                    Container(
                      alignment: Alignment.center,
                      child: Text('Display Tab 3',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                    ),
                  ]))
            ]),
            floatingActionButton: _showButton ? _floatingButton : SizedBox(),
          )
        : SizedBox();
  }
}

class _UserScore extends StatelessWidget {
  _UserScore({Key key, this.score}) : super(key: key);

  final double score;
  final List<Widget> stars = List();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    double _score = score;
    for (int i = 0; i < 5; i++) {
      stars.add(Icon(
        _score >= 1.0
            ? Icons.star
            : (_score >= 0.25 ? Icons.star_half : Icons.star_outline),
        color: theme.accentColor,
      ));
      _score -= 1.0;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: stars +
          [
            SizedBox(
              width: 8,
            ),
            Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: BorderRadius.circular(50)),
                child: Text(
                  score.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ))
          ],
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
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 8),
                    labelText: "Nombre del Objeto"),
                onSaved: (input) => widget.objetoLista.nombre = input,
              ),
              subtitle: TextFormField(
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

class _NewListForm extends StatefulWidget {
  _NewListForm({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewListFormState();
}

class _NewListFormState extends State<_NewListForm> {
  Lista newLista = Lista();
  final _listFormKey = GlobalKey<FormState>();
  bool _listCheckboxValue = true;

  List<ObjetoLista> objetosLista = List();
  List<GlobalKey<_NewListObjState>> objetosListaKeys = List();
  List<Widget> objsListaWidgets = List();

  void save() {
    _listFormKey.currentState.save();
    objetosListaKeys.forEach((element) {
      element.currentState.save();
    });
    newLista.esPublico = _listCheckboxValue;
    newLista.objetos = objetosLista;
    //print(newLista.toJson());
    ListaServices.create(newLista);
  }

  void addObjetoLista() {
    objetosLista.add(ObjetoLista());
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
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 450,
      child: Form(
        key: _listFormKey,
        child: ListView(
          children: [
                TextFormField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 8),
                      labelText: "Nombre de Lista"),
                  onSaved: (input) => newLista.nombre = input,
                ),
                TextFormField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 8),
                      labelText: "Descripcion de la Lista"),
                  onSaved: (input) => newLista.descripcion = input,
                ),
                CheckboxListTile(
                  value: _listCheckboxValue,
                  onChanged: (val) {
                    setState(() => _listCheckboxValue = val);
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
                    onPressed: addObjetoLista),
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

class _CustomList extends StatelessWidget {
  _CustomList({Key key, this.list}) : super(key: key);

  final Lista list;

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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
