import 'package:Xchangez/LandingPage.dart';
import 'package:Xchangez/model/Usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CustomSearchBar.dart';
import 'package:Xchangez/UserIconButton.dart';
import 'package:Xchangez/extensions/NotificationBadge.dart';
import 'package:Xchangez/extensions/SimpleIconButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomNavBar extends StatefulWidget with PreferredSizeWidget {
  CustomNavBar(this.isMenuOpen, this.onClick,
      {Key key, this.size = 50, this.authUser})
      : preferredSize = Size.fromHeight(size + 10),
        super(key: key);

  @override
  final Size preferredSize;

  final Function onClick;
  final bool isMenuOpen;

  final double size;

  final Usuario authUser;

  @override
  State<StatefulWidget> createState() => _CustomNavState();
}

class _CustomNavState extends State<CustomNavBar> {
  bool isSearching = false;

  OverlayEntry _overlayEntry;

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: 400,
        height: 400,
        right: 100,
        top: widget.size,
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          elevation: 4.0,
          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.history_rounded),
                trailing: InkWell(
                  child: Icon(Icons.close_rounded),
                  onTap: () {},
                ),
                title: Text('Syria'),
                onTap: () {
                  print('Syria Tapped');
                },
              ),
              ListTile(
                title: Text('Lebanon'),
                onTap: () {
                  print('Lebanon Tapped');
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showMenu() {
    setState(() {
      this._overlayEntry = this._createOverlayEntry();
      Overlay.of(context).insert(this._overlayEntry);
    });
  }

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
              isBigEnoughProfile
                  ? UserIconButton(
                      authUser: widget.authUser,
                    )
                  : SizedBox(),
              IconButton(
                  icon: NotificationBadge(
                      child: Icon(Icons.notifications_rounded),
                      notifications: 0),
                  onPressed: _showMenu),
              IconButton(
                  icon: NotificationBadge(
                      child: Icon(Icons.chat_bubble), notifications: 0),
                  onPressed: () {}),
              IconButton(icon: Icon(Icons.more_vert_rounded), onPressed: logout)
            ],
            flexibleSpace: isBigEnoughSearch
                ? Container(
                    margin: EdgeInsets.fromLTRB(
                        250, 0, isBigEnoughProfile ? 275 : 140, 0),
                    height: widget.preferredSize.height,
                    child: CustomSearchBar(),
                  )
                : SizedBox())
        : AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back_rounded),
                onPressed: () => setState(() {
                      isSearching = false;
                    })),
            flexibleSpace: Container(
              margin: EdgeInsets.fromLTRB(65, 0, 10, 0),
              height: widget.preferredSize.height,
              child: CustomSearchBar(),
            ));
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.push(
        context, MaterialPageRoute(builder: (_context) => LandingPage()));
  }
}
