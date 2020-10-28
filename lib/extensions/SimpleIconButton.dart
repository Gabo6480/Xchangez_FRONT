import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SimpleIconButton extends StatelessWidget {
  SimpleIconButton(
      {Key key, this.borderRadius, this.icon, this.child, this.onTap})
      : super(key: key);

  BorderRadius borderRadius;
  Widget icon;
  Widget child;
  Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: borderRadius,
      child: Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 15, 0),
          child: Row(
            children: [icon, SizedBox(width: 5), child],
          )),
      onTap: onTap,
    );
  }
}
