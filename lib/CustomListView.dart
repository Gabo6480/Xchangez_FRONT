import 'package:Xchangez/CustomItemCard.dart';
import 'package:Xchangez/model/Publicacion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomListView extends StatefulWidget {
  CustomListView({Key key}) : super(key: key);

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
        margin: EdgeInsets.symmetric(vertical: 5),
        width: double.infinity,
        height: 275,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Scrollbar(
                controller: _controller,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                  itemExtent: cardWidth,
                  scrollDirection: Axis.horizontal,
                  controller: _controller,
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return CustomItemCard(Publicacion());
                  },
                )),
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
        ));
  }
}
