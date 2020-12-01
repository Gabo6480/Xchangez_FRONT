import 'package:Xchangez/LandingPage.dart';
import 'package:Xchangez/model/Usuario.dart';
import 'package:Xchangez/services/api.services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CustomNavBar.dart';
import 'package:Xchangez/user/UserIconButton.dart';

import 'package:Xchangez/CreationAlerts.dart';

class CustomScaffold extends StatefulWidget {
  CustomScaffold(this.body, {Key key, this.floatingActionButton})
      : super(key: key);

  final Widget body;
  final Widget floatingActionButton;

  @override
  State<StatefulWidget> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  bool isMenuOpen = false;

  Usuario authUser;
  void _getUser() {
    authUser = APIServices.getLoggedUser();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final mQuery = MediaQuery.of(context);

    double width =
        mQuery.size.width * 0.85 < 330 ? mQuery.size.width * 0.85 : 330;

    return Scaffold(
        backgroundColor: theme.backgroundColor,
        appBar: CustomNavBar(
            isMenuOpen,
            () => setState(() {
                  isMenuOpen = !isMenuOpen;
                }),
            authUser: authUser),
        floatingActionButton: widget.floatingActionButton,
        body: Stack(
          children: [
            widget.body,
            IgnorePointer(
                ignoring: !isMenuOpen,
                child: GestureDetector(
                  child: AnimatedOpacity(
                      opacity: isMenuOpen ? 1 : 0,
                      duration: Duration(milliseconds: 500),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.black45,
                      )),
                  onTap: () => setState(() {
                    isMenuOpen = !isMenuOpen;
                  }),
                )),
            AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeIn,
                left: !isMenuOpen ? -width : 0,
                width: width,
                height: mQuery.size.height,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  color: theme.backgroundColor,
                  child: ListTileTheme(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                          UserIconButton(authUser: authUser),
                          Divider(
                            height: 30,
                            color: Colors.black26,
                            thickness: 1,
                          ),
                          ListTile(
                            leading: Icon(Icons.home),
                            title: Text("Inicio"),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_context) => LandingPage()));
                            },
                          ),
                        ] +
                        (APIServices.loggedInUser != null
                            ? <Widget>[
                                ListTile(
                                  leading: Icon(Icons.note_add_outlined),
                                  title: Text("Nueva Publicacion"),
                                  onTap: () {
                                    createPublicacion(context);
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.post_add),
                                  title: Text("Nueva Lista"),
                                  onTap: () {
                                    createLista(context);
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.logout),
                                  title: Text("Cerrar Sesión"),
                                  onTap: () async {
                                    await APIServices.disposeToken();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_context) =>
                                                LandingPage()));
                                  },
                                )
                              ]
                            : <Widget>[]),
                  )),
                ))
          ],
        ));
  }
}
