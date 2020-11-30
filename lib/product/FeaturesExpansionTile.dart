import 'package:flutter/material.dart';

class FeaturesExpansionTile extends StatefulWidget {
  FeaturesExpansionTile(this.features, {Key key}) : super(key: key);

  final Map<String, dynamic> features;

  @override
  State<StatefulWidget> createState() => FeaturesExpansionTileState();
}

class FeaturesExpansionTileState extends State<FeaturesExpansionTile> {
  Map<String, String> _features = Map();

  List<Widget> _featureWidgets = List();
  List<GlobalKey<_FeatureTileState>> _featureKeys = List();

  @override
  void initState() {
    super.initState();

    if (widget.features.isNotEmpty) {
      widget.features.forEach((key, value) {
        addFeature(key, value);
      });
    }
  }

  void addFeature(String key, String value) {
    _featureKeys.add(GlobalKey<_FeatureTileState>());
    _featureWidgets
        .add(FeatureTile(key, value, removeFeature, key: _featureKeys.last));
    setState(() {});
  }

  void removeFeature(Key key) {
    int index = _featureKeys.indexOf(key);
    _featureKeys.removeAt(index);
    _featureWidgets.removeAt(index);

    setState(() {});
  }

  bool validateFeatures() {
    bool result = true;
    _featureKeys.forEach((element) {
      result = element.currentState.validate() && result;
    });

    return result;
  }

  Map<String, dynamic> saveFeatures() {
    _features.clear();

    for (var item in _featureKeys) {
      var newF = item.currentState.save();
      if (!_features.containsKey(newF.key))
        _features.putIfAbsent(newF.key, () => newF.value);
      else {
        int tries = 0;
        while (_features.containsKey(newF.key + " " + tries.toString())) {
          tries++;
        }
        _features.putIfAbsent(
            newF.key + " " + tries.toString(), () => newF.value);
      }
    }

    return _features;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text("Características"),
      children: <Widget>[
            FlatButton(
              minWidth: double.infinity,
              child: Icon(Icons.add, color: Colors.white),
              color: Colors.greenAccent,
              onPressed: () => addFeature("", ""),
            ),
          ] +
          _featureWidgets,
    );
  }
}

class FeatureTile extends StatefulWidget {
  FeatureTile(this.llave, this.valor, this.remove, {Key key}) : super(key: key);

  final String llave;
  final String valor;

  final Function(Key key) remove;

  @override
  State<StatefulWidget> createState() => _FeatureTileState();
}

class _FeatureTileState extends State<FeatureTile> {
  final _formKey = GlobalKey<FormState>();

  String _key;
  String _value;

  @override
  void initState() {
    super.initState();

    _key = widget.llave;
    _value = widget.valor;

    _keyController = TextEditingController(text: _key)
      ..addListener(() {
        _key = _keyController.text;
      });

    _valueController = TextEditingController(text: _value)
      ..addListener(() {
        _value = _valueController.text;
      });
  }

  bool validate() {
    return _formKey.currentState.validate();
  }

  MapEntry<String, String> save() {
    _formKey.currentState.save();

    return MapEntry(_key, _value);
  }

  var _keyController;
  var _valueController;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Form(
        key: _formKey,
        child: ListTile(
          title: SizedBox(
              width: width * 0.40,
              child: TextFormField(
                controller: _keyController,
                style: TextStyle(fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 8),
                  labelText: "Titulo",
                ),
                onSaved: (input) => _key = input,
                validator: (s) =>
                    s.isEmpty ? "Al menos un título es requerio" : null,
              )),
          trailing: SizedBox(
              width: width * 0.45,
              child: TextFormField(
                controller: _valueController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 8),
                  labelText: "Especificación",
                ),
                onSaved: (input) => _value = input,
              )),
          leading: IconButton(
            icon: Icon(Icons.close, color: Colors.redAccent),
            onPressed: () => widget.remove(widget.key),
          ),
        ));
  }
}
