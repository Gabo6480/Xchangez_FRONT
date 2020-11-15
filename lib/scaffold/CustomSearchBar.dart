import 'package:Xchangez/SearchPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  CustomSearchBar({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final FocusNode _focusNode = FocusNode();

  OverlayEntry _overlayEntry;

  final LayerLink _layerLink = LayerLink();

  final _searchQueryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        this._overlayEntry = this._createOverlayEntry();
        Overlay.of(context).insert(this._overlayEntry);
      } else {
        this._overlayEntry.remove();
      }

      setState(() {});
    });
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;
    return OverlayEntry(
        builder: (context) => Positioned(
              width: size.width,
              child: CompositedTransformFollower(
                link: this._layerLink,
                showWhenUnlinked: false,
                offset: Offset(0.0, size.height - 25.0),
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
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
            ));
  }

  void _cancel() {
    setState(() {
      _searchQueryController.clear();
      //_list.clear();
      //_error = null;
      //_loading = false;
    });
  }

  void _search(BuildContext context, String search) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_context) => SearchPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: CompositedTransformTarget(
          link: this._layerLink,
          child: TextField(
            focusNode: this._focusNode,
            controller: _searchQueryController,
            decoration: InputDecoration(
              prefixIcon: InkWell(
                child: Icon(Icons.search_rounded),
                onTap: () {
                  if (_searchQueryController.text.isNotEmpty)
                    _search(context, _searchQueryController.text);
                },
              ),
              suffixIcon: _focusNode.hasFocus
                  ? InkWell(
                      child: Icon(Icons.close_rounded),
                      onTap: _cancel,
                    )
                  : SizedBox(),
              border: InputBorder.none,
              hintText: "Buscar...",
            ),
            onSubmitted: (string) {
              _search(context, string);
            },
          ),
        ));
  }
}
