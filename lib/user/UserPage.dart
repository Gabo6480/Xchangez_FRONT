import 'dart:math';

import 'package:Xchangez/extensions/CircleImage.dart';
import 'package:Xchangez/extensions/HoverText.dart';
import 'package:Xchangez/extensions/StarCounter.dart';
import 'package:Xchangez/model/Usuario.dart';
import 'package:Xchangez/scaffold/CustomScaffold.dart';
import 'package:Xchangez/CustomGridView.dart';
import 'package:Xchangez/services/api.lista.dart';
import 'package:Xchangez/services/api.publicacion.dart';
import 'package:Xchangez/services/api.services.dart';
import 'package:Xchangez/services/api.valoracion.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'ListaCustomList.dart';

import 'package:Xchangez/CreationAlerts.dart';

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

  Usuario authUser;
  void _getUser() async {
    authUser = await APIServices.getUser(widget.userID);
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
              onPressed: () =>
                  createPublicacion(context, updateParent: _getUser));
          setState(() {});
          break;
        case 1:
          _floatingButton = FloatingActionButton(
              child: Icon(Icons.post_add),
              onPressed: () => createLista(context, updateParent: _getUser));
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
                    StarCounter(
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
                      child: CustomGridView(
                        PublicacionServices.getAllfromUser(widget.userID),
                        updateParent: _getUser,
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: FutureBuilder(
                          future: ListaServices.getAllByUserId(widget.userID),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                        ConnectionState.none &&
                                    snapshot.hasData == null ||
                                snapshot.data == null)
                              return Text('Cargando...',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold));
                            else
                              return ListView.builder(
                                itemCount: snapshot.data.length + 1,
                                itemBuilder: (context, index) {
                                  if (index < snapshot.data.length)
                                    return ListaCustomList(
                                      list: snapshot.data[index],
                                      delete: (lista) => deleteLista(
                                          context, lista,
                                          updateParent: _getUser),
                                      edit: (lista) => editLista(context, lista,
                                          updateParent: _getUser),
                                      isOwner: widget.isLoggedUser,
                                    );
                                  else if (snapshot.data.isNotEmpty)
                                    return SizedBox();
                                  else
                                    return Text('Aquí no hay nada...',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold));
                                },
                              );
                          },
                        )),
                    Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: FutureBuilder(
                          future:
                              ValoracionServices.getAllForUserId(widget.userID),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                        ConnectionState.none &&
                                    snapshot.hasData == null ||
                                snapshot.data == null)
                              return Text('Cargando...',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold));
                            else
                              return ListView.builder(
                                itemCount: snapshot.data.length + 1,
                                itemBuilder: (context, index) {
                                  if (index < snapshot.data.length)
                                    return ListTile(
                                        leading: CircleImage(
                                          image: NetworkImage(snapshot
                                              .data[index].rutaImagenAvatar),
                                        ),
                                        title: HoverText(
                                            snapshot.data[index].nombreCompleto,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                            onTap: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_context) =>
                                                        UserPage(snapshot
                                                            .data[index]
                                                            .idUsuario)))),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            StarCounter(
                                              score:
                                                  snapshot.data[index].cantidad,
                                            ),
                                            Text(
                                                snapshot.data[index].comentario)
                                          ],
                                        ));
                                  else if (snapshot.data.isNotEmpty)
                                    return SizedBox();
                                  else
                                    return Text('Aquí no hay nada...',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold));
                                },
                              );
                          },
                        ))
                  ]))
            ]),
            floatingActionButton: _showButton ? _floatingButton : SizedBox(),
          )
        : SizedBox();
  }
}
