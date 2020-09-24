import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xchangez/SingleFormPage.dart';

import 'LoginPage.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();

  bool isPasswordVisible1 = false;
  bool isPasswordVisible2 = false;

  @override
  Widget build(BuildContext context) {
    final mQuery = MediaQuery.of(context);

    double width = mQuery.size.width < 300 ? mQuery.size.width : 300;

    ThemeData theme = Theme.of(context);

    const double inputSeparation = 15;

    double maxWidth = width * 2 + inputSeparation * 5;

    return SingleFormPage(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Form(
            key: formKey,
            child: Column(children: [
              Wrap(
                spacing: 20,
                runSpacing: 15,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Container(
                    width: width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 8),
                            prefixIcon: Icon(Icons.person),
                            labelText: "Nombre/s",
                          ),
                          //onSaved: (input) => _email = input,
                          validator: (input) {
                            return null;
                          },
                        ),
                        SizedBox(
                          height: inputSeparation,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 8),
                            prefixIcon: Icon(Icons.person_outlined),
                            labelText: "Apellido/s",
                          ),
                          //onSaved: (input) => _email = input,
                          validator: (input) {
                            return null;
                          },
                        ),
                        SizedBox(
                          height: inputSeparation,
                        ),
                        DateTimeField(
                            initialValue: DateTime.now(),
                            keyboardType: TextInputType.datetime,
                            format: DateFormat("dd / MM / yyyy"),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(left: 8),
                              prefixIcon: Icon(Icons.date_range),
                              labelText: "Fecha de nacimiento",
                            ),
                            //onSaved: (input) => _email = input,
                            validator: (value) {
                              return null;
                            },
                            onShowPicker: (_context, _date) async {
                              return showDatePicker(
                                  context: _context,
                                  locale: Locale("es"),
                                  firstDate: DateTime(1900),
                                  initialDate: _date ?? DateTime.now(),
                                  lastDate: DateTime(2100));
                            })
                      ],
                    ),
                  ),
                  Container(
                    width: width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 8),
                            prefixIcon: Icon(Icons.alternate_email),
                            labelText: "Correo electrónico",
                          ),
                          //onSaved: (input) => _email = input,
                          validator: (input) {
                            return null;
                          },
                        ),
                        SizedBox(
                          height: inputSeparation,
                        ),
                        TextFormField(
                          obscureText: !isPasswordVisible1,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 8),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(isPasswordVisible1
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible1 = !isPasswordVisible1;
                                });
                              },
                            ),
                            labelText: "Contraseña",
                          ),
                          //onSaved: (input) => _email = input,
                          validator: (input) {
                            return null;
                          },
                        ),
                        SizedBox(
                          height: inputSeparation,
                        ),
                        TextFormField(
                          obscureText: !isPasswordVisible2,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 8),
                            prefixIcon: Icon(Icons.lock_outlined),
                            suffixIcon: IconButton(
                              icon: Icon(isPasswordVisible2
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined),
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible2 = !isPasswordVisible2;
                                });
                              },
                            ),
                            labelText: "Confirmar contraseña",
                          ),
                          //onSaved: (input) => _email = input,
                          validator: (input) {
                            return null;
                          },
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: width,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                            highlightElevation: 0,
                            padding: EdgeInsets.symmetric(vertical: 17),
                            child: Text("Registrarme"),
                            onPressed: () {})),
                  ),
                  Container(
                      width: width,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                              text: "Al registrarme, declaro que acepto los ",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                              children: [
                                TextSpan(
                                  text: "Términos y Condiciones",
                                  style: TextStyle(
                                      color: theme.accentColor,
                                      decoration: TextDecoration.underline),
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () =>
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_context) =>
                                                  LoginPage()))
                                    ,
                                ),
                                TextSpan(text: " y las "),
                                TextSpan(
                                  text: "Politicas de Privacidad",
                                  style: TextStyle(
                                      color: theme.accentColor,
                                      decoration: TextDecoration.underline),
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_context) =>
                                                  LoginPage()));
                                    },
                                ),
                                TextSpan(text: " de Xchangez."),
                              ])))
                ],
              ),
              SizedBox(
                  width: mQuery.size.width < maxWidth ? width : maxWidth,
                  child: Divider(
                    height: inputSeparation,
                    color: Colors.black26,
                    thickness: 1,
                  )),
              Text(
                "¿Ya tienes una cuenta? ",
                style: TextStyle(color: Colors.grey),
              ),
              RichText(
                  text: TextSpan(
                text: "Ingresar",
                style: TextStyle(
                    color: theme.accentColor,
                    decoration: TextDecoration.underline),
                recognizer: new TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_context) => LoginPage()));
                  },
              ))
            ])));
  }
}
