import 'dart:math';
import 'dart:typed_data';

import 'package:Xchangez/scaffold/CustomScaffold.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  Uint8List _profile;
  Uint8List _background;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    var mQuery = MediaQuery.of(context);

    double padding =
        min(250, mQuery.size.width * 0.2 - 100).clamp(0, double.maxFinite);

    double imageSize = max(100 + padding * 0.5, 150);

    double height = mQuery.size.height;

    return CustomScaffold(ListView(children: [
      Container(
          padding: EdgeInsets.symmetric(horizontal: padding),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(color: Colors.black26, spreadRadius: 3, blurRadius: 5)
          ]),
          child: Column(children: [
            Stack(children: [
              Container(
                alignment: Alignment.bottomCenter,
                width: double.infinity,
                height: 200 + padding,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26, spreadRadius: 3, blurRadius: 5)
                    ],
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: _background == null
                            ? NetworkImage(
                                "https://media.vandal.net/i/1000x562/26509/grand-theft-auto-san-andreas-2014102794311_1.jpg")
                            : MemoryImage(_background))),
                child: Container(
                  alignment: Alignment.bottomRight,
                  width: imageSize,
                  height: imageSize,
                  transform: Matrix4.translationValues(0, 25, 0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 6),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 3,
                            blurRadius: 5)
                      ],
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: _profile == null
                              ? NetworkImage("https://i.imgur.com/BoN9kdC.png")
                              : MemoryImage(_profile))),
                  child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: IconButton(
                          icon: Icon(Icons.camera_alt),
                          onPressed: () async {
                            FilePickerResult result = await FilePicker.platform
                                .pickFiles(type: FileType.image);
                            if (result != null)
                              setState(() {
                                _profile = result.files.single.bytes;
                              });
                          })),
                ),
              ),
              Positioned(
                  right: 8,
                  bottom: 8,
                  child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white60),
                      child: IconButton(
                          color: Colors.black87,
                          icon: Icon(Icons.image),
                          onPressed: () async {
                            FilePickerResult result = await FilePicker.platform
                                .pickFiles(type: FileType.image);
                            if (result != null)
                              setState(() {
                                _background = result.files.single.bytes;
                              });
                          })))
            ]),
            SizedBox(
              height: 20,
            ),
            Text(
              "Carl Johnson",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            UserScore(
              score: 3.4,
            ),
            Divider(
              color: Colors.black26,
              thickness: 1,
            ),
            Container(
                width: 800,
                child: TabBar(
                  controller: _tabController,
                  labelColor: theme.primaryColor,
                  indicatorColor: theme.primaryColor,
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Tab(text: 'Publicaciónes'),
                    Tab(text: 'Gustos'),
                    Tab(text: 'Información')
                  ],
                )),
          ])),
      Container(
          height: height * .9,
          child: TabBarView(controller: _tabController, children: [
            Container(
              alignment: Alignment.center,
              child: Text('Display Tab 1',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ),
            Container(
              alignment: Alignment.center,
              child: Text('Display Tab 2',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ),
            Container(
              alignment: Alignment.center,
              child: Text('Display Tab 3',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            )
          ]))
    ]));
  }
}

class UserScore extends StatelessWidget {
  UserScore({Key key, this.score}) : super(key: key);

  final double score;
  final List<Widget> stars = List();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    double _score = score;
    for (int i = 0; i < 5; i++) {
      stars.add(Icon(
        _score >= 1.0
            ? Icons.star
            : (_score >= 0.25 ? Icons.star_half : Icons.star_outline),
        color: theme.accentColor,
      ));
      _score -= 1.0;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: stars +
          [
            SizedBox(
              width: 8,
            ),
            Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: BorderRadius.circular(50)),
                child: Text(
                  score.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ))
          ],
    );
  }
}
