import 'package:Xchangez/LandingPage.dart';

import 'CustomSearchBar.dart';
import 'package:Xchangez/UserIconButton.dart';
import 'package:Xchangez/extensions/NotificationBadge.dart';
import 'package:Xchangez/extensions/SimpleIconButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomNavBar extends StatefulWidget with PreferredSizeWidget {
  CustomNavBar(this.isMenuOpen, this.onClick, {Key key, this.size = 50})
      : preferredSize = Size.fromHeight(size + 40 + 10),
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
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    final mQuery = MediaQuery.of(context);

    bool isBigEnoughProfile = mQuery.size.width > 800;
    bool isBigEnoughSearch = mQuery.size.width > 650;

    ThemeData theme = Theme.of(context);

    if (isBigEnoughSearch && isSearching)
      setState(() {
        isSearching = false;
      });

    return !isSearching || isBigEnoughSearch
        ? AppBar(
            title: InkWell(
              child: Image.asset(
                mQuery.size.width > 400
                    ? 'assets/images/Xchangez_no_background_OW.png'
                    : 'assets/images/Xchangez_no_background_OW_mini.png',
                scale: 3.1,
              ),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_context) => LandingPage())),
            ),
            leading: IconButton(
                icon: Icon(widget.isMenuOpen
                    ? Icons.menu_open_rounded
                    : Icons.menu_rounded),
                onPressed: widget.onClick),
            actions: [
              !isBigEnoughSearch
                  ? IconButton(
                      icon: Icon(Icons.search_rounded),
                      onPressed: () => setState(() {
                            isSearching = true;
                          }))
                  : SizedBox(),
              isBigEnoughProfile ? UserIconButton() : SizedBox(),
              IconButton(
                  icon: NotificationBadge(
                      child: Icon(Icons.notifications_rounded),
                      notifications: 0),
                  onPressed: () {}),
              IconButton(
                  icon: NotificationBadge(
                      child: Icon(Icons.chat_bubble), notifications: 0),
                  onPressed: () {}),
              IconButton(icon: Icon(Icons.more_vert_rounded), onPressed: () {})
            ],
            flexibleSpace: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isBigEnoughSearch
                      ? Container(
                          margin: EdgeInsets.fromLTRB(
                              250, 0, isBigEnoughProfile ? 275 : 140, 0),
                          height: widget.preferredSize.height - 40,
                          child: CustomSearchBar(),
                        )
                      : SizedBox(),
                  underButtons(theme.accentColor)
                ]))
        : AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back_rounded),
                onPressed: () => setState(() {
                      isSearching = false;
                    })),
            flexibleSpace: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(65, 0, 10, 0),
                    height: widget.preferredSize.height - 40,
                    child: CustomSearchBar(),
                  ),
                  underButtons(theme.accentColor)
                ]));
  }

  Widget underButtons(Color color) {
    return Container(
        height: 40,
        color: Colors.black12,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            SimpleIconButton(
              borderRadius: BorderRadius.circular(8),
              icon: Icon(
                Icons.place_rounded,
                color: color,
              ),
              child: Text(
                "Ubicación",
                style: TextStyle(
                    color: color, fontSize: 15, fontWeight: FontWeight.bold),
              ),
              onTap: () {},
            )
          ],
        ));
  }
}
