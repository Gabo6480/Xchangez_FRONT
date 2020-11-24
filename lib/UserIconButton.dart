import 'package:Xchangez/LoginPage.dart';
import 'package:Xchangez/UserPage.dart';
import 'package:Xchangez/extensions/CircleImage.dart';
import 'package:Xchangez/extensions/SimpleIconButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/Usuario.dart';

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

  Usuario authUser;

  @override
  Widget build(BuildContext context) {
    return SimpleIconButton(
      borderRadius: BorderRadius.circular(40),
      icon: CircleImage(
        size: 40,
        image: NetworkImage((authUser == null)
            ? "http://ssl.gstatic.com/accounts/ui/avatar_2x.png"
            : authUser.imagenPerfil),
      ),
      child: Text(authUser == null ? "Iniciar Sesión" : authUser.nombre),
      onTap: () =>
          authUser == null ? _goToLogin(context) : _goToProfile(context),
    );
  }
}
