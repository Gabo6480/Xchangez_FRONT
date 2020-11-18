import 'package:Xchangez/LoginPage.dart';
import 'package:Xchangez/extensions/CircleImage.dart';
import 'package:Xchangez/extensions/SimpleIconButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserIconButton extends StatelessWidget {

  _goToLogin(BuildContext context) {}

  UserIconButton({Key key, this.nombreUsuario}) : super(key: key);

  String nombreUsuario;

  @override
  Widget build(BuildContext context) {
    return SimpleIconButton(
      borderRadius: BorderRadius.circular(40),
      icon: CircleImage(
        size: 40,
        image: NetworkImage("https://i.imgur.com/BoN9kdC.png"),
      ),
      child: Text(nombreUsuario ?? "Iniciar Sesión"),
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_context) => LoginPage())),
    );
  }
}
