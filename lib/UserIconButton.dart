import 'package:Xchangez/LoginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserIconButton extends StatelessWidget {
  _goToLogin(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      child: Padding(
          padding: EdgeInsets.fromLTRB(5, 0, 20, 0),
          child: Row(
            children: [
              Icon(Icons.circle, size: 50),
              SizedBox(width: 5),
              Text("Ingresar")
            ],
          )),
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_context) => LoginPage())),
    );
  }
}
