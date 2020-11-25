import 'package:Xchangez/model/Usuario.dart';
import 'package:Xchangez/services/api.services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CustomNavBar.dart';
import 'package:Xchangez/UserIconButton.dart';

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
                  color: theme.backgroundColor,
                  child: UserIconButton(authUser: authUser),
                ))
          ],
        ));
  }
}
