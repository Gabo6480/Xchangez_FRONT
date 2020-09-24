import 'package:Xchangez/extensions/SimpleIconButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleIconButton(
      borderRadius: BorderRadius.circular(50),
      icon: Icon(Icons.circle, size: 50),
      child: Text("Nombre"),
      onTap: () {},
    );
  }
}
