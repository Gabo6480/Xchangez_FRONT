import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  String _email;

  bool loginFail;

  @override
  Widget build(BuildContext context) {
    final mQuery = MediaQuery.of(context);
    double width = mQuery.size.width < 300 ? mQuery.size.width : 300;

    ThemeData theme = Theme.of(context);

    return Scaffold(
        backgroundColor: theme.backgroundColor,
        body: Center(
            child: Column(
          children: [
            Image.asset(
              'assets/images/Xchangez_no_background_OW.png',
              scale: 1.30,
            ),
            Container(
                width: width,
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 8),
                            suffixIcon: Icon(Icons.person),
                            labelText: "Correo",
                          ),
                          onSaved: (input) => _email = input,
                          validator: (input) {
                            RegExp regex = new RegExp(
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                            if (!regex.hasMatch(input))
                              return 'Ingrese un Correo Válido';
                            else if (loginFail) {
                              loginFail = false;
                              return "Revise su correo o la contraseña";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(left: 8),
                              suffixIcon: Icon(Icons.lock),
                              labelText: "Contraseña"),
                          obscureText: true,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                            width: double.infinity,
                            child: RaisedButton(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Text("Ingresar"),
                                onPressed: () {}))
                      ],
                    )))
          ],
        )));
  }
}
