import 'package:Xchangez/CommentTile.dart';
import 'package:Xchangez/CustomCarousel.dart';
import 'package:Xchangez/extensions/VideoPlayer.dart';
import 'package:Xchangez/scaffold/CustomScaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ProductItemPage extends StatefulWidget {
  ProductItemPage({Key key}) : super(key: key);

  final Map<String, String> features = {
    "Marca": "Algo",
    "Modelo": "MK2",
    "Velocidad": "Bien rapido"
  };

  @override
  State<StatefulWidget> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItemPage> {
  List<Widget> _caracteristicas = List();

  @override
  void initState() {
    super.initState();
    widget.features.forEach((key, value) {
      _caracteristicas.add(ListTile(
        title: Text(key,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        trailing: Text(value),
      ));
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    double carousel = min(600, width * .85);

    return CustomScaffold(ListView(children: [
      Container(
        width: double.infinity,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(15),
        //height: 100,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(1.0, 0), //(x,y)
                blurRadius: 6.0,
              )
            ],
            borderRadius: BorderRadius.circular(20)),
        child: Wrap(
          //crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.spaceAround,
          children: [
            Container(
              width: carousel,
              child: CustomCarousel(
                height: carousel,
                autoPlay: false,
                items: [
                  VideoPlayerScreen(
                      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
                  Image.network(
                      'https://techcrunch.com/wp-content/uploads/2020/05/DSC00537.jpg?w=1390&crop=1'),
                ],
              ),
            ),
            Container(
              width: carousel,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text("Producto bien chidote asu bien perro",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 28)),
                      subtitle: Text(
                          "Publicado hace un pitero de tiempo alch ya ni me acuerdo jsjsjs",
                          style: TextStyle(fontSize: 12)),
                    ),
                    ListTile(title: Text("\$123123")),
                    ListTile(
                      title: Text("Dueño",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      subtitle: UserScoreCard(score: 3.4),
                    ),
                    ExpansionTile(
                        title: Text("Características",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        children: _caracteristicas),
                    ListTile(
                      title: Text("Descripción",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      subtitle: Text(
                          "TEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT TEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT TEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT TEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT"),
                    ),
                  ]),
            )
          ],
        ),
      ),
      Container(
          width: double.infinity,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          //height: 100,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(1.0, 0), //(x,y)
                  blurRadius: 6.0,
                )
              ],
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              ResponseTextFiled(),
              Divider(
                color: Colors.black26,
                thickness: 1,
              ),
              CommentTile(),
              CommentTile()
            ],
          ))
    ]));
  }
}

class UserScoreCard extends StatelessWidget {
  UserScoreCard({Key key, this.score}) : super(key: key);

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

    return ListTile(
      leading: Icon(Icons.circle, size: 50),
      title: Text("Vendedor Ofertón",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      subtitle: Row(
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
      ),
    );
  }
}
