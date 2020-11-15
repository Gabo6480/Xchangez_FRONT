import 'package:Xchangez/model/UserInfo.dart';
import 'package:Xchangez/services/api.services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'RegisterPage.dart';
import 'model/UserToken.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  final RoundedLoadingButtonController _btnLogin =
      new RoundedLoadingButtonController();

  UserInfo usuario = UserInfo();
  bool _remember = false;
  bool loginFail = false;
  String errorLogin = "test";

  @override
  Widget build(BuildContext context) {
    final mQuery = MediaQuery.of(context);
    double width = mQuery.size.width < 300 ? mQuery.size.width : 300;

    ThemeData theme = Theme.of(context);

    return Scaffold(
        backgroundColor: theme.backgroundColor,
        body: Stack(children: [
          Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                  gradient: RadialGradient(
                      center: Alignment.bottomLeft,
                      radius: 13,
                      colors: [theme.primaryColorDark, theme.primaryColor]))),
          Center(
              child: Column(
            children: [
              SizedBox(
                height: mQuery.size.height * .02,
              ),
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
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(left: 8),
                              suffixIcon: Icon(Icons.alternate_email),
                              labelText: "Correo electrónico",
                            ),
                            onSaved: (input) => usuario.correo = input,
                            validator: (input) {
                              RegExp regex = new RegExp(
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                              if (!regex.hasMatch(input)) {
                                _btnLogin.reset();
                                return 'Ingrese un Correo Válido';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(left: 8),
                                suffixIcon: Icon(Icons.lock),
                                labelText: "Contraseña"),
                            onSaved: (input) => usuario.password = input,
                            validator: (input) {
                              if (input.isEmpty) {
                                _btnLogin.reset();
                                return "Ingrese la contraseña";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: RoundedLoadingButton(
                              color: Color.fromRGBO(255, 120, 10, 1),
                              child: Text("Ingresar",
                                  style: TextStyle(color: Colors.white)),
                              controller: _btnLogin,
                              onPressed: _summit,
                            ),
                            // child: RaisedButton(
                            //   highlightElevation: 0,
                            //   padding: EdgeInsets.symmetric(vertical: 17),
                            //   child: Text("Ingresar"),
                            //   onPressed: () => _summit()
                            // )
                          ),
                          Visibility(
                              child: Container(
                                child: Center(
                                    child: Text(
                                  errorLogin,
                                  style: TextStyle(color: Colors.redAccent),
                                )),
                                margin: EdgeInsets.only(top: 10),
                              ),
                              visible: loginFail),
                          CheckboxListTile(
                              value: _remember,
                              controlAffinity: ListTileControlAffinity.leading,
                              title: Text("Recuérdame"),
                              onChanged: (value) {
                                setState(() {
                                  _remember = value ?? false;
                                });
                              }),
                          SizedBox(
                            height: 5,
                          ),
                          RichText(
                              text: TextSpan(
                            text: "¿Olvidaste tu contraseña?",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                                decoration: TextDecoration.underline),
                            recognizer: new TapGestureRecognizer()
                              ..onTap = () {},
                          )),
                          Divider(
                            color: Colors.black26,
                            thickness: 1,
                          ),
                          Text(
                            "¿No tienes una cuenta? ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          RichText(
                              text: TextSpan(
                            text: "Regístrate",
                            style: TextStyle(
                                color: theme.accentColor,
                                decoration: TextDecoration.underline),
                            recognizer: new TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_context) => RegisterPage()));
                              },
                          ))
                        ],
                      )))
            ],
          ))
        ]));
  }

  void _summit() async {
    setState(() {
      loginFail = false;
      errorLogin = '';
    });

    if (!formKey.currentState.validate()) {
      return;
    }

    formKey.currentState.save();

    try {

      UserToken userToken = await APIServices.login(usuario);
      
      setState(() {
        _btnLogin.success();
      });

      print(userToken.token);

    } catch (error) {

      setState(() {
        loginFail = true;
        errorLogin = error;
        _btnLogin.reset();
      });
    }
  }
}
