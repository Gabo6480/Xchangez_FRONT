import 'package:Xchangez/CustomItemCard.dart';
import 'package:Xchangez/model/Publicacion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomListView extends StatefulWidget {
  CustomListView(this.titulo, this.future, {Key key}) : super(key: key);
  final String titulo;
  final Future<dynamic> future;
  @override
  State<StatefulWidget> createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    Color arrowColor = Colors.black;
    double cardWidth = 175;

    return Container(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(left: 15, top: 8),
                child: Text(
                  widget.titulo,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )),
            Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                width: double.infinity,
                height: 275,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    FutureBuilder(
                      future: widget.future,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.none &&
                                snapshot.hasData == null ||
                            snapshot.data == null)
                          return Text('Cargando...',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold));
                        else if (snapshot.data.isNotEmpty)
                          return Scrollbar(
                              controller: _controller,
                              child: ListView.builder(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 5),
                                itemExtent: cardWidth,
                                scrollDirection: Axis.horizontal,
                                controller: _controller,
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return CustomItemCard(snapshot.data[index]);
                                },
                              ));
                        else
                          return Text('Aquí no hay nada...',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold));
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color: Color(0xfff2f2f2),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    bottomRight: Radius.circular(5))),
                            child: InkWell(
                              child: Icon(
                                Icons.arrow_left,
                                color: arrowColor,
                                size: 50,
                              ),
                              onTap: () => _controller.animateTo(
                                  _controller.offset - cardWidth,
                                  curve: Curves.linear,
                                  duration: Duration(milliseconds: 500)),
                            )),
                        Container(
                            decoration: BoxDecoration(
                                color: Color(0xfff2f2f2),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    bottomLeft: Radius.circular(5))),
                            child: InkWell(
                              child: Icon(
                                Icons.arrow_right,
                                color: arrowColor,
                                size: 50,
                              ),
                              onTap: () => _controller.animateTo(
                                  _controller.offset + cardWidth,
                                  curve: Curves.linear,
                                  duration: Duration(milliseconds: 500)),
                            ))
                      ],
                    )
                  ],
                ))
          ],
        ));
  }
}
