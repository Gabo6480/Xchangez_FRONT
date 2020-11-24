import 'dart:math';
import 'dart:typed_data';

import 'package:Xchangez/model/Usuario.dart';
import 'package:Xchangez/scaffold/CustomScaffold.dart';
import 'package:Xchangez/services/api.services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserPage extends StatefulWidget {
  UserPage(this.userID, {Key key}) : super(key: key);

  int userID;

  @override
  State<StatefulWidget> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  Usuario authUser;
  void _getAuthUserName() async {
    authUser = await APIServices.getUser(widget.userID);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _getAuthUserName();
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

    return authUser != null
        ? CustomScaffold(ListView(children: [
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
                        child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: IconButton(
                                icon: Icon(Icons.camera_alt),
                                onPressed: () async {
                                  FilePickerResult result = await FilePicker
                                      .platform
                                      .pickFiles(type: FileType.image);
                                  if (result != null) if (await APIServices
                                      .updateAvatar(result.files.single, 1))
                                    _getAuthUserName();
                                })),
                      ),
                    ),
                    Positioned(
                        right: 8,
                        bottom: 8,
                        child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white60),
                            child: IconButton(
                                color: Colors.black87,
                                icon: Icon(Icons.image),
                                onPressed: () async {
                                  FilePickerResult result = await FilePicker
                                      .platform
                                      .pickFiles(type: FileType.image);
                                  if (result != null) if (await APIServices
                                      .updateAvatar(result.files.single, 2))
                                    _getAuthUserName();
                                })))
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    authUser.nombre + " " + authUser.apellido,
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
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
                        tabs: [Tab(text: 'Publicaciónes'), Tab(text: 'Gustos')],
                      )),
                ])),
            Container(
                height: height - 153,
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
                        children: [
                          _CustomList(),
                          _CustomList(),
                          _CustomList(),
                        ],
                      ))
                ]))
          ]))
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

class _CustomListTile extends StatelessWidget {
  _CustomListTile({Key key, this.has = true}) : super(key: key);

  final bool has;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Nombre"),
      subtitle: Text(
          "DESCRIPCIOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOONNNNNNNNN TEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT"),
      trailing: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            color: has ? Colors.lightGreen : Colors.lightBlue,
            borderRadius: BorderRadius.circular(8)),
        child: Text(
          has ? "Tengo" : "Busco",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _CustomList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        children: [
          Text(
            "Titulo de la lista",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Text(
              "DESCRIPCIOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOONNNNNNNNN: TEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT TEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT"),
          Divider(
            color: Colors.black26,
            thickness: 1,
          ),
          _CustomListTile(has: true),
          _CustomListTile(has: false),
          _CustomListTile(has: false),
          _CustomListTile(has: true),
        ],
      ),
    );
  }
}
