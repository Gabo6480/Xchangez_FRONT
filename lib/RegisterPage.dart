import 'package:flutter/material.dart';

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
              child: Column(children: [
            SizedBox(
              height: mQuery.size.height * .02,
            ),
            Image.asset(
              'assets/images/Xchangez_no_background_OW.png',
              scale: 1.30,
            ),
            Container(
                //width: width,
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Form(
                    key: formKey,
                    child: Wrap(
                      spacing: 20,
                      runSpacing: 15,
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
                              TextFormField(
                                keyboardType: TextInputType.datetime,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 8),
                                  prefixIcon: Icon(Icons.date_range),
                                  labelText: "Fecha de Nacimiento",
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
                                        isPasswordVisible1 =
                                            !isPasswordVisible1;
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
                                        isPasswordVisible2 =
                                            !isPasswordVisible2;
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
                        )
                      ],
                    )))
          ]))
        ]));
  }
}
