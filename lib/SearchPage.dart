import 'dart:math';

import 'package:Xchangez/CustomExpansionTile.dart';
import 'package:Xchangez/CustomGridView.dart';
import 'package:Xchangez/scaffold/CustomScaffold.dart';
import 'package:Xchangez/services/api.publicacion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchQuery {
  String texto;
  int ordenar;
  int estado;
  int fechaDePublicacion;
  bool trueques;
  double precioMin;
  double precioMax;

  SearchQuery(
      {this.texto = "",
      this.ordenar = 0,
      this.estado = 0,
      this.fechaDePublicacion = 0,
      this.trueques = false,
      this.precioMin = 0,
      this.precioMax = double.maxFinite});
}

class SearchPage extends StatefulWidget {
  SearchPage(this.query, {Key key}) : super(key: key);

  final SearchQuery query;

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isMenuOpen = false;

  RegExp _regex;

  @override
  void initState() {
    super.initState();

    String reg = r"(";
    RegExp(r"([\S])+")
        .allMatches(widget.query.texto)
        .map((e) => e[0])
        .forEach((element) {
      reg += element + "|";
    });
    reg = reg.substring(0, max(reg.length - 1, 1)) + ")+";

    _regex = RegExp(reg);

    _getResults();
  }

  Widget results;
  int resultQuan = 0;
  void _getResults() {
    results = CustomGridView(
        PublicacionServices.getAll(quantity: 99999).then((value) {
      var result = value
          .where((element) =>
              (_regex.hasMatch(element.titulo) ||
                  _regex.hasMatch(element.descripcion) ||
                  _regex.hasMatch(element.caracteristicas.toString()) ||
                  _regex.hasMatch(element.estado.toString())) &&
              (element.estado.index == widget.query.estado ||
                  widget.query.estado == 0) &&
              ((widget.query.fechaDePublicacion == 1 &&
                      element.fechaAlta.isAfter(
                          DateTime.now().subtract(Duration(days: 1)))) ||
                  (widget.query.fechaDePublicacion == 2 &&
                      element.fechaAlta.isAfter(
                          DateTime.now().subtract(Duration(days: 7)))) ||
                  (widget.query.fechaDePublicacion == 3 &&
                      element.fechaAlta.isAfter(
                          DateTime.now().subtract(Duration(days: 30)))) ||
                  widget.query.fechaDePublicacion == 0) &&
              (element.esTrueque == widget.query.trueques ||
                  !widget.query.trueques) &&
              (element.precio >= widget.query.precioMin) &&
              (element.precio <= widget.query.precioMax))
          .toList();
      resultQuan = result.length;

      //Testear
      if (widget.query.ordenar == 0) {
        result.sort((a, b) => a.visitas.compareTo(b.visitas));
      } else if (widget.query.ordenar == 1) {
        result.sort((a, b) => a.precio.compareTo(b.precio));
      } else {
        result.sort((a, b) => b.precio.compareTo(a.precio));
      }

      setState(() {});
      return result;
    }));
  }

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
                  child: FilterList(widget.query, resultQuan)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                width: mQuery.size.width - width,
                child: results,
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
                child: results,
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
                          SizedBox(
                              height: height - 86,
                              child: FilterList(widget.query, resultQuan))
                        ],
                      )))
            ],
          ));
  }
}

class FilterList extends StatefulWidget {
  FilterList(this.query, this.resultQuan, {Key key}) : super(key: key);

  final SearchQuery query;
  final int resultQuan;

  @override
  State<StatefulWidget> createState() => _FilterListState();
}

class _FilterListState extends State<FilterList> {
  //int _orderBy = 0;
  //int _itemState = 0;
  //int _time = 0;
  //bool _isTrade = false;

  final _orderByKey = GlobalKey<CustomExpansionTileState>();
  final _itemStateKey = GlobalKey<CustomExpansionTileState>();
  final _timeKey = GlobalKey<CustomExpansionTileState>();

  TextEditingController _controllerMin;
  TextEditingController _controllerMax;

  final _controllerScroll = ScrollController();

  @override
  void initState() {
    super.initState();

    _controllerMin = TextEditingController(
        text: widget.query.precioMin != 0
            ? widget.query.precioMin.toString()
            : "")
      ..addListener(() {
        widget.query.precioMin = _controllerMin.text.isNotEmpty
            ? double.tryParse(_controllerMin.text)
            : 0;
      });

    _controllerMax = TextEditingController(
        text: widget.query.precioMax != double.maxFinite
            ? widget.query.precioMax.toString()
            : "")
      ..addListener(() {
        widget.query.precioMax = _controllerMax.text.isNotEmpty
            ? double.tryParse(_controllerMax.text)
            : double.maxFinite;
      });
  }

  @override
  Widget build(BuildContext context) {
    bool isFiltered = widget.query.ordenar != 0 ||
        widget.query.estado != 0 ||
        widget.query.fechaDePublicacion != 0 ||
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
                  widget.query.texto,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
                Text(widget.resultQuan.toString() + " resultados"),
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
                  initialSelection: widget.query.ordenar,
                  key: _orderByKey,
                  title: "Ordenar por",
                  options: ["Más relevantes", "Mayor precio", "Menor precio"],
                  onChange: (v) => setState(() {
                    widget.query.ordenar = v;
                  }),
                ),
                CustomExpansionTile(
                  initialSelection: widget.query.estado,
                  key: _itemStateKey,
                  title: "Estado del artículo",
                  options: ["Todo", "Nuevo", "Usado"],
                  onChange: (v) => setState(() {
                    widget.query.estado = v;
                  }),
                ),
                CustomExpansionTile(
                  initialSelection: widget.query.fechaDePublicacion,
                  key: _timeKey,
                  title: "Fecha de publicación",
                  options: [
                    "Todo",
                    "Últimas 24 horas",
                    "Últimos 7 días",
                    "Últimos 30 días",
                  ],
                  onChange: (v) => setState(() {
                    widget.query.fechaDePublicacion = v;
                  }),
                ),
                CheckboxListTile(
                    value: widget.query.trueques,
                    title: Text("Trueques",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    onChanged: (value) {
                      setState(() {
                        widget.query.trueques = value ?? false;
                      });
                    }),
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
                                  RegExp(r'[0-9]+\.?[0-9]*')),
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
                                  RegExp(r'[0-9]+\.?[0-9]*')),
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
                RaisedButton(
                  child: Text("Refrescar"),
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_context) => SearchPage(widget.query))),
                )
              ],
            )));
  }
}
