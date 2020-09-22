import 'package:Xchangez/extensions/NotificationBadge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomNavBar extends StatefulWidget with PreferredSizeWidget {
  CustomNavBar(this.isMenuOpen, this.onClick, {Key key, this.size = 50})
      : preferredSize = Size.fromHeight(size * 2 + 10),
        super(key: key);

  @override
  final Size preferredSize;

  final Function onClick;
  final bool isMenuOpen;

  final double size;

  @override
  State<StatefulWidget> createState() => _CustomNavState();
}

class _CustomNavState extends State<CustomNavBar> {
  @override
  Widget build(BuildContext context) {
    final mQuery = MediaQuery.of(context);

    bool isBigEnoughProfile = mQuery.size.width > 800;
    bool isBigEnoughSearch = mQuery.size.width > 650;

    return AppBar(
      title: GestureDetector(
          child: Image.asset(
        mQuery.size.width > 400
            ? 'assets/images/Xchangez_no_background_OW.png'
            : 'assets/images/Xchangez_no_background_OW_mini.png',
        scale: 3.1,
      )),
      leading: IconButton(
          icon: Icon(
              widget.isMenuOpen ? Icons.menu_open_rounded : Icons.menu_rounded),
          onPressed: widget.onClick),
      actions: [
        !isBigEnoughSearch
            ? IconButton(icon: Icon(Icons.search_rounded), onPressed: () {})
            : SizedBox(),
        isBigEnoughProfile
            ? InkWell(
                borderRadius: BorderRadius.circular(50),
                child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 20, 0),
                    child: Row(
                      children: [
                        Icon(Icons.circle, size: 50),
                        SizedBox(width: 5),
                        Text("Nombre")
                      ],
                    )),
                onTap: () {},
              )
            : SizedBox(),
        IconButton(
            icon: NotificationBadge(
                child: Icon(Icons.notifications_rounded), notifications: 0),
            onPressed: () {}),
        IconButton(
            icon: NotificationBadge(
                child: Icon(Icons.chat_bubble), notifications: 0),
            onPressed: () {}),
        IconButton(icon: Icon(Icons.more_vert_rounded), onPressed: () {})
      ],
      flexibleSpace: isBigEnoughSearch
          ? Container(
              margin: EdgeInsets.fromLTRB(
                  250, 0, isBigEnoughProfile ? 275 : 150, 0),
              color: Colors.green,
              height: widget.preferredSize.height - widget.size,
            )
          : SizedBox(),
      /*bottom: TabBar(tabs: [
        Tab(
          icon: Icon(Icons.home),
        ),
        Tab(
          icon: Icon(Icons.home),
        ),
        Tab(
          icon: Icon(Icons.home),
        ),
        Tab(
          icon: Icon(Icons.home),
        ),
        Tab(
          icon: Icon(Icons.home),
        )
      ]),*/
    );
  }
}
