import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CustomNavBar.dart';
import 'UserIconButton.dart';

class CustomScaffold extends StatefulWidget {
  CustomScaffold(this.body, {Key key}) : super(key: key);

  final Widget body;

  @override
  State<StatefulWidget> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  bool isMenuOpen = false;

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
                })),
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
                  child: UserIconButton(),
                ))
          ],
        ));
  }
}
