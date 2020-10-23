import 'package:Xchangez/LoginPage.dart';
import 'package:Xchangez/extensions/SimpleIconButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserIconButton extends StatelessWidget {
  _goToLogin(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return SimpleIconButton(
      borderRadius: BorderRadius.circular(50),
      icon: Icon(Icons.circle, size: 50),
      child: Text("Nombre"),
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_context) => LoginPage())),
    );
  }
}
