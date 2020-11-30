import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomExpansionTile extends StatefulWidget {
  CustomExpansionTile(
      {Key key,
      this.title = "",
      this.options,
      this.onChange,
      this.initialSelection = 0})
      : super(key: key);

  final String title;
  final List<String> options;
  final Function(int) onChange;
  final int initialSelection;

  @override
  State<StatefulWidget> createState() => CustomExpansionTileState();
}

class CustomExpansionTileState extends State<CustomExpansionTile> {
  int _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.initialSelection;
  }

  void clearSelection() {
    setState(() {
      _selectedOption = 0;
      widget.onChange(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    List<Widget> children = List<Widget>();

    for (int i = 0; i < widget.options.length; i++) {
      children.add(RadioListTile(
        dense: true,
        value: i,
        groupValue: _selectedOption,
        onChanged: (v) => setState(() {
          _selectedOption = v;
          widget.onChange(v);
        }),
        title: Text(widget.options[i]),
      ));
    }

    bool isSelected = _selectedOption != 0;

    return Theme(
        data: theme.copyWith(
            textTheme: TextTheme(
                subtitle1: TextStyle(
                    color: isSelected
                        ? theme.accentColor
                        : theme.textTheme.subtitle1.color))),
        child: ExpansionTile(
          key:
              GlobalKey(), //Al colocarle una llave vacía siempre que cambia el estado de CustomExpansionTile, el estado de ExpansionTile es limpiado causando que se cierre
          title: Text(
              widget.title +
                  (isSelected ? (": " + widget.options[_selectedOption]) : ""),
              style: TextStyle(fontWeight: FontWeight.bold)),
          children: children,
        ));
  }
}
