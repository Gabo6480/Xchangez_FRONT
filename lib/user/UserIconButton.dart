import 'package:Xchangez/LoginPage.dart';
import 'package:Xchangez/user/UserPage.dart';
import 'package:Xchangez/extensions/CircleImage.dart';
import 'package:Xchangez/extensions/SimpleIconButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/Usuario.dart';

class UserIconButton extends StatelessWidget {
  _goToLogin(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_context) => LoginPage()));
  }

  _goToProfile(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (_context) => UserPage(authUser.id)));
  }

  UserIconButton({Key key, this.authUser}) : super(key: key);

  final Usuario authUser;

  @override
  Widget build(BuildContext context) {
    bool isUser = authUser == null;

    return SimpleIconButton(
      borderRadius: BorderRadius.circular(40),
      icon: CircleImage(
        size: 40,
        image: NetworkImage(isUser
            ? "http://ssl.gstatic.com/accounts/ui/avatar_2x.png"
            : authUser.imagenPerfil),
      ),
      child: Text(isUser ? "Iniciar Sesión" : authUser.nombre),
      onTap: () => isUser ? _goToLogin(context) : _goToProfile(context),
    );
  }
}
