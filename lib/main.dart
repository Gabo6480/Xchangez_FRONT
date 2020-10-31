import 'package:Xchangez/LandingPage.dart';
import 'package:Xchangez/ProductItemPage.dart';
import 'package:Xchangez/UserPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: MaterialApp(
          title: 'Xchangez',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primaryColor: Color(0xff008dff),
            primaryColorDark: Color(0xff03435c),

            buttonTheme: ButtonThemeData(
                buttonColor: Color(0xffff7200),
                textTheme: ButtonTextTheme.primary),

            accentColor: Color(0xffff7200),
            accentTextTheme: TextTheme(
                bodyText1: TextStyle(
              fontSize: 20,
              color: Colors.white,
            )),
            backgroundColor: Color(0xffe5dcdf),
            // This makes the visual density adapt to the platform that you run
            // the app on. For desktop platforms, the controls will be smaller and
            // closer together (more dense) than on mobile platforms.
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          //home: UserPage(),
          home: LandingPage(),

          localizationsDelegates: [
            // ... app-specific localization delegate[s] here
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [const Locale('es', ''), const Locale('en', '')],
        ));
  }
}
