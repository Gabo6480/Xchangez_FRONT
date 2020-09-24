import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingleFormPage extends StatelessWidget {
  SingleFormPage(
      {Key key, this.child, this.width, this.height, this.constraints})
      : super(key: key);

  final Widget child;
  final double width;
  final double height;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    final mQuery = MediaQuery.of(context);

    ThemeData theme = Theme.of(context);

    return Scaffold(
        backgroundColor: theme.backgroundColor,
        body: Stack(children: [
          Container(
              width: double.infinity,
              height: mQuery.size.height * .27,
              decoration: BoxDecoration(
                  gradient: RadialGradient(
                      center: Alignment.bottomLeft,
                      radius: 13,
                      colors: [theme.primaryColorDark, theme.primaryColor]))),
          Center(
              child: Column(children: [
            SizedBox(
              height: mQuery.size.height * .02,
            ),
            Image.asset(
              'assets/images/Xchangez_no_background_OW.png',
              scale: 1.30,
            ),
            Container(
                width: width,
                height: height,
                constraints: constraints,
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: child)
          ]))
        ]));
  }
}
