import 'package:Xchangez/CustomCarousel.dart';
import 'package:Xchangez/CustomListView.dart';
import 'package:Xchangez/product/ProductNewItem.dart';
import 'package:Xchangez/scaffold/CustomScaffold.dart';
import 'package:Xchangez/services/api.publicacion.dart';
import 'package:Xchangez/services/api.services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  void sharedPreferences() async {
    if (APIServices.loggedInUser == null) {
      if (await APIServices.getRememberFromStorage()) {
        await APIServices.getAuthUser();
        Navigator.push(
            context, MaterialPageRoute(builder: (_context) => LandingPage()));
      } else {
        await APIServices.disposeToken();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    sharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    double carouselHeight = width > 800 ? width * 0.25 : 200;

    return CustomScaffold(ListView(children: [
      CustomCarousel(
        height: carouselHeight,
      ),
      CustomListView("Popular", PublicacionServices.getAllRelevant()),
      CustomListView("Reciente", PublicacionServices.getAllRecent()),
      APIServices.loggedInUser != null
          ? CustomListView(
              "De tus seguidos", PublicacionServices.getAllFromFollowing())
          : SizedBox(),
      CustomListView("Variado", PublicacionServices.getAll())
    ]));
  }
}
