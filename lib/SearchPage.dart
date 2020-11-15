import 'package:Xchangez/CustomExpansionTile.dart';
import 'package:Xchangez/CustomGridView.dart';
import 'package:Xchangez/scaffold/CustomScaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    final mQuery = MediaQuery.of(context);
    double width =
        mQuery.size.width * 0.33 < 330 ? mQuery.size.width * 0.33 : 330;

    double height = mQuery.size.height * .7;

    return CustomScaffold(mQuery.size.width > 800
        ? Row(
            children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  height: double.infinity,
                  width: width,
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(1.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    )
                  ]),
                  child: FilterList()),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                width: mQuery.size.width - width,
                child: CustomGridView(),
              )
            ],
          )
        : Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                height: mQuery.size.height - 115,
                width: mQuery.size.width,
                child: CustomGridView(),
              ),
              IgnorePointer(
                  ignoring: !isMenuOpen,
                  child: GestureDetector(
                    child: AnimatedOpacity(
                        opacity: isMenuOpen ? 1 : 0,
                        duration: Duration(milliseconds: 500),
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: Colors.black45,
                        )),
                    onTap: () => setState(() {
                      isMenuOpen = !isMenuOpen;
                    }),
                  )),
              AnimatedPositioned(
                  duration: Duration(milliseconds: 500),
                  bottom: isMenuOpen ? 0 : -height + 85,
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      width: mQuery.size.width,
                      height: height * .95,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(1.0, 1.0), //(x,y)
                              blurRadius: 6.0,
                            )
                          ],
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          RaisedButton(
                              highlightElevation: 0,
                              padding: EdgeInsets.symmetric(vertical: 17),
                              child: Text("Filtros"),
                              onPressed: () => setState(() {
                                    isMenuOpen = !isMenuOpen;
                                  })),
                          SizedBox(height: height - 86, child: FilterList())
                        ],
                      )))
            ],
          ));
  }
}

class FilterList extends StatefulWidget {
  FilterList({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FilterListState();
}

class _FilterListState extends State<FilterList> {
  int _orderBy = 0;
  int _itemState = 0;
  int _time = 0;

  final _orderByKey = GlobalKey<CustomExpansionTileState>();
  final _itemStateKey = GlobalKey<CustomExpansionTileState>();
  final _timeKey = GlobalKey<CustomExpansionTileState>();

  final _controllerMin = TextEditingController();
  final _controllerMax = TextEditingController();

  final _controllerScroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    bool isFiltered = _orderBy != 0 ||
        _itemState != 0 ||
        _time != 0 ||
        _controllerMin.text != "" ||
        _controllerMax.text != "";
    return GestureDetector(
        onTap: () => setState(() {}),
        child: Scrollbar(
            controller: _controllerScroll,
            isAlwaysShown: true,
            child: ListView(
              controller: _controllerScroll,
              children: [
                Text(
                  "Artículo",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
                Text("69420" + " resultados"),
                Divider(
                  height: 30,
                  color: Colors.black26,
                  thickness: 2,
                ),
                ListTile(
                    selected: isFiltered,
                    title: Text(
                      "Filtros",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    trailing: (isFiltered)
                        ? IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () => setState(() {
                              _orderByKey.currentState.clearSelection();
                              _itemStateKey.currentState.clearSelection();
                              _timeKey.currentState.clearSelection();
                              _controllerMin.text = "";
                              _controllerMax.text = "";
                            }),
                          )
                        : SizedBox()),
                CustomExpansionTile(
                  key: _orderByKey,
                  title: "Ordenar por",
                  options: ["Más relevantes", "Más relevantes", "Menor precio"],
                  onChange: (v) => setState(() {
                    _orderBy = v;
                  }),
                ),
                CustomExpansionTile(
                  key: _itemStateKey,
                  title: "Estado del artículo",
                  options: ["Todo", "Nuevo", "Usado"],
                  onChange: (v) => setState(() {
                    _itemState = v;
                  }),
                ),
                CustomExpansionTile(
                  key: _timeKey,
                  title: "Fecha de publicación",
                  options: [
                    "Todo",
                    "Últimas 24 horas",
                    "Últimos 7 días",
                    "Últimos 30 días",
                  ],
                  onChange: (v) => setState(() {
                    _time = v;
                  }),
                ),
                ListTile(
                  title: Text(
                    "Precio",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      SizedBox(
                          width: 110,
                          child: TextField(
                            controller: _controllerMin,
                            decoration: InputDecoration(
                                prefixText: "\$", hintText: "Min."),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                              LengthLimitingTextInputFormatter(10),
                            ],
                            onChanged: (txt) => setState(() {}),
                          )),
                      SizedBox(
                          width: 110,
                          child: TextField(
                            controller: _controllerMax,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                prefixText: "\$", hintText: "Max."),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                              LengthLimitingTextInputFormatter(10),
                            ],
                            onChanged: (txt) => setState(() {}),
                          )),
                    ],
                  ),
                ),
                Divider(
                  height: 30,
                  color: Colors.black26,
                  thickness: 2,
                ),
              ],
            )));
  }
}
