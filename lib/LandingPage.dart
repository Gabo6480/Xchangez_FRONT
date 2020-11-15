import 'package:Xchangez/CustomCarousel.dart';
import 'package:Xchangez/CustomListView.dart';
import 'package:Xchangez/scaffold/CustomScaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    double carouselHeight = width > 800 ? width * 0.25 : 200;

    return CustomScaffold(ListView(children: [
      CustomCarousel(
        height: carouselHeight,
      ),
      Container(
          color: Colors.white,
          margin: EdgeInsets.symmetric(vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 15, top: 8),
                  child: Text(
                    "Popular",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  )),
              CustomListView()
            ],
          )),
    ]));
  }
}
