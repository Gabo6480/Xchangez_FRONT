import 'dart:async';

import 'package:Xchangez/model/Usuario.dart';
import 'package:Xchangez/services/api.services.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import './extensions/HoverText.dart';

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
  String confirmPassword = '';
  bool isError = false;
  String errorMessage = '';

  final Usuario usuario = new Usuario();

  final RoundedLoadingButtonController _btnRegister =
      new RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    final mQuery = MediaQuery.of(context);

    double width = mQuery.size.width < 300 ? mQuery.size.width : 300;

    ThemeData theme = Theme.of(context);

    const double inputSeparation = 15;

    double maxWidth = width * 2 + inputSeparation * 5;

    return Scaffold(
        backgroundColor: theme.backgroundColor,
        body: ListView(children: [
          SingleChildScrollView(
              child: Stack(children: [
            Container(
                width: double.infinity,
                height: 200,
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
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  padding: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
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
                                    onSaved: (input) => usuario.nombre = input,
                                    validator: (input) {
                                      if (input.isEmpty) {
                                        _btnRegister.reset();
                                        return "Ingrese su(s) nombre(s)";
                                      }
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
                                    onSaved: (input) =>
                                        usuario.apellido = input,
                                    validator: (input) {
                                      if (input.isEmpty) {
                                        _btnRegister.reset();
                                        return "Ingrese su(s) apellido(s)";
                                      }
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
                                        contentPadding:
                                            EdgeInsets.only(left: 8),
                                        prefixIcon: Icon(Icons.date_range),
                                        labelText: "Fecha de nacimiento",
                                      ),
                                      onSaved: (input) =>
                                          usuario.fechaNacimiento = input,
                                      validator: (value) {
                                        if (value == null) {
                                          _btnRegister.reset();
                                          return "Ingrese la fecha de su nacimiento";
                                        }
                                        return null;
                                      },
                                      onShowPicker: (_context, _date) async {
                                        return showDatePicker(
                                            context: _context,
                                            locale: Locale("es"),
                                            firstDate: DateTime(1900),
                                            initialDate:
                                                _date ?? DateTime.now(),
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
                                    onSaved: (input) => usuario.correo = input,
                                    validator: (input) {
                                      RegExp regex = new RegExp(
                                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                                      if (!regex.hasMatch(input)) {
                                        _btnRegister.reset();
                                        return 'Ingrese un correo valido';
                                      }
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
                                            isPasswordVisible1 =
                                                !isPasswordVisible1;
                                          });
                                        },
                                      ),
                                      labelText: "Contraseña",
                                    ),
                                    onSaved: (input) =>
                                        usuario.password = input,
                                    validator: (input) {
                                      if (input.isEmpty) {
                                        _btnRegister.reset();
                                        return "Ingrese la contraseña que usará para ingresar";
                                      }
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
                                            isPasswordVisible2 =
                                                !isPasswordVisible2;
                                          });
                                        },
                                      ),
                                      labelText: "Confirmar contraseña",
                                    ),
                                    onSaved: (input) => confirmPassword = input,
                                    validator: (input) {
                                      if (input.isEmpty) {
                                        _btnRegister.reset();
                                        return "Confirme la contraseña";
                                      }
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
                                child: RoundedLoadingButton(
                                  color: Color.fromRGBO(255, 120, 10, 1),
                                  child: Text("Registrarme",
                                      style: TextStyle(color: Colors.white)),
                                  controller: _btnRegister,
                                  onPressed: _summit,
                                ),
                              ),
                            ),
                            Container(
                                width: width,
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: RichText(
                                    textAlign: TextAlign.justify,
                                    text: TextSpan(
                                        text:
                                            "Al registrarme, declaro que acepto los ",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black54,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: "Términos y Condiciones",
                                            style: TextStyle(
                                                color: theme.accentColor,
                                                decoration:
                                                    TextDecoration.underline),
                                            recognizer:
                                                new TapGestureRecognizer()
                                                  ..onTap = () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (_context) =>
                                                                LoginPage()));
                                                  },
                                          ),
                                          TextSpan(text: " y las "),
                                          TextSpan(
                                            text: "Politicas de Privacidad",
                                            style: TextStyle(
                                                color: theme.accentColor,
                                                decoration:
                                                    TextDecoration.underline),
                                            recognizer:
                                                new TapGestureRecognizer()
                                                  ..onTap = () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (_context) =>
                                                                LoginPage()));
                                                  },
                                          ),
                                          TextSpan(text: " de Xchangez."),
                                        ]))),
                            Visibility(
                                child: Container(
                                  child: Center(
                                      child: Text(
                                    errorMessage,
                                    style: TextStyle(color: Colors.redAccent),
                                  )),
                                  margin: EdgeInsets.only(top: 10),
                                ),
                                visible: isError),
                          ],
                        ),
                        SizedBox(
                            width:
                                mQuery.size.width < maxWidth ? width : maxWidth,
                            child: Divider(
                              height: inputSeparation,
                              color: Colors.black26,
                              thickness: 1,
                            )),
                        Text(
                          "¿Ya tienes una cuenta? ",
                          style: TextStyle(color: Colors.grey),
                        ),
                        HoverText("Ingresar",
                            style: TextStyle(
                                color: theme.accentColor,
                                decoration: TextDecoration.underline),
                            onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_context) => LoginPage()));
                        }),
                      ])))
            ]))
          ]))
        ]));
  }

  void _summit() async {
    showErrorMessage(message: '', show: false);

    if (!formKey.currentState.validate()) {
      return;
    }

    formKey.currentState.save();

    if (!camposValidos()) return;

    try {
      Usuario usuarioRegistrado = await APIServices.register(usuario);

      if (usuarioRegistrado == null) {
        showErrorMessage(
            message: 'El usuario no se ha registrado por alguna razón',
            resetButton: true);
        return;
      }

      _btnRegister.success();

      //Redirigimos a la pantalla de login
      Timer(Duration(milliseconds: 250), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_context) => LoginPage()));
      });
    } catch (error) {
      showErrorMessage(message: error.toString(), resetButton: true);
      return;
    }
  }

  void showErrorMessage(
      {String message = '', bool show = true, bool resetButton = false}) {
    setState(() {
      isError = show;
      errorMessage = message;
      if (resetButton) _btnRegister.reset();
    });
  }

  bool camposValidos() {
    if (confirmPassword != usuario.password) {
      showErrorMessage(
          message: 'Las contraseñas no coinciden', resetButton: true);
      return false;
    }

    return true;
  }
}
