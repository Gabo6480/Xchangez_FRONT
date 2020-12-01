import 'package:Xchangez/model/Publicacion.dart';
import 'package:Xchangez/services/api.publicacion.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mime/mime.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../CustomExpansionTile.dart';
import 'FeaturesExpansionTile.dart';

class ProductNewItem extends StatefulWidget {
  ProductNewItem({Key key, this.edit}) : super(key: key);

  final Publicacion edit;

  @override
  State<StatefulWidget> createState() => ProductNewItemState();
}

class ProductNewItemState extends State<ProductNewItem> {
  Publicacion newPubli;
  final _formKey = GlobalKey<FormState>();

  final _itemStateKey = GlobalKey<CustomExpansionTileState>();

  final _featureStateKey = GlobalKey<FeaturesExpansionTileState>();

  final List<PlatformFile> archivos = List();
  final List<Widget> archivosWidget = List();

  String _archivosError = "";

  Future<bool> saveAs(bool isDraft) async {
    if (!isDraft) {
      if (!validateRequirements()) return false;
    }

    _formKey.currentState.save();

    newPubli.caracteristicas = _featureStateKey.currentState.saveFeatures();

    newPubli.esBorrador = isDraft;

    var createdPubli;

    if (widget.edit == null)
      createdPubli = await PublicacionServices.create(newPubli);
    else {
      createdPubli = await PublicacionServices.updatePost(newPubli);
      //Eliminar todos los archivos
      await PublicacionServices.deleteAllFilesFromPost(createdPubli.id);
    }

    for (var element in archivos) {
      await PublicacionServices.addFile(createdPubli.id, element);
    }

    return true;
  }

  void removeFile(PlatformFile file) {
    archivos.remove(file);
    setState(() {});
  }

  bool validateRequirements() {
    bool result = _formKey.currentState.validate();

    result = _featureStateKey.currentState.validateFeatures() && result;

    bool imagen = false;
    for (var item in archivos) {
      if (lookupMimeType(item.name).contains("image")) {
        imagen = true;
        break;
      }
    }
    _archivosError = "";
    if (!imagen) {
      _archivosError = "La publicación requiere al menos una imagen";
      result = false;
    }
    setState(() {});
    return result;
  }

  void loadImages() async {
    var images = await PublicacionServices.getFilesByPostId(widget.edit.id);

    for (var element in images) {
      http.Response response = await http
          .get("https://cors-anywhere.herokuapp.com/" + element.ruta, headers: {
        'Content-Type': lookupMimeType(element.nombre + element.ecstension)
      });

      archivos.add(PlatformFile(
          name: element.nombre + element.ecstension,
          bytes: response.bodyBytes));
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    if (widget.edit != null) {
      newPubli = widget.edit;
      loadImages();
    } else
      newPubli = Publicacion();

    _priceController = TextEditingController(
        text: newPubli.precio == 0 ? "" : newPubli.precio.toString())
      ..addListener(() {
        newPubli.precio = double.tryParse(_priceController.text);
      });

    _descController = TextEditingController(text: newPubli.descripcion)
      ..addListener(() {
        newPubli.descripcion = _descController.text;
      });

    _nameController = TextEditingController(text: newPubli.titulo)
      ..addListener(() {
        newPubli.titulo = _nameController.text;
      });
  }

  var _priceController;
  var _descController;
  var _nameController;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    ThemeData theme = Theme.of(context);

    archivosWidget.clear();

    archivos.forEach((element) {
      archivosWidget.add(ListTile(
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.redAccent),
          onPressed: () => removeFile(element),
        ),
        title: Text(element.name),
      ));
    });

    return Container(
      width: width * .9,
      height: 450,
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
                TextFormField(
                  controller: _nameController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 8),
                      labelText: "Titulo de la publicación"),
                  onSaved: (input) => newPubli.titulo = input,
                  validator: (s) =>
                      s.isEmpty ? "La publicación requiere un título" : null,
                ),
                TextFormField(
                  controller: _descController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 8),
                      labelText: "Descripcion de la publicación"),
                  onSaved: (input) => newPubli.descripcion = input,
                  validator: (s) => s.isEmpty
                      ? "La publicación requiere una descripción"
                      : null,
                ),
                TextFormField(
                  controller: _priceController,
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'[0-9]+\.?[0-9]*')),
                    LengthLimitingTextInputFormatter(10),
                  ],
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 8),
                      prefixText: "\$",
                      labelText: "Precio"),
                  onSaved: (input) =>
                      newPubli.precio = input.isEmpty ? 0 : double.parse(input),
                  validator: (s) => (!newPubli.esTrueque &&
                          (s.isEmpty || double.parse(s) <= 0))
                      ? "La publicación debe de tener un precio o aceptar trueques"
                      : null,
                ),
                CheckboxListTile(
                  value: newPubli.esTrueque,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (val) {
                    setState(() => newPubli.esTrueque = val);
                  },
                  title: Text("¿Acepta trueques?"),
                ),
                CustomExpansionTile(
                  key: _itemStateKey,
                  title: "Estado del artículo",
                  initialSelection: newPubli.estado.index,
                  options: ["Indefinido", "Nuevo", "Usado"],
                  onChange: (v) => setState(() {
                    newPubli.estado = Estado.values[v];
                  }),
                ),
                FeaturesExpansionTile(newPubli.caracteristicas,
                    key: _featureStateKey),
                Divider(
                  color: Colors.black26,
                  thickness: 1,
                ),
                IconButton(
                    icon: Icon(Icons.add_photo_alternate),
                    color: Colors.greenAccent,
                    onPressed: () async {
                      FilePickerResult result = await FilePicker.platform
                          .pickFiles(type: FileType.media, allowMultiple: true);
                      if (result != null) {
                        archivos.addAll(result.files);
                      }
                      setState(() {});
                    }),
                Divider(
                  color: _archivosError.isEmpty
                      ? Colors.black26
                      : theme.errorColor,
                  thickness: 1,
                ),
                _archivosError.isNotEmpty
                    ? Text(
                        _archivosError,
                        style: TextStyle(color: theme.errorColor, fontSize: 12),
                      )
                    : SizedBox()
              ] +
              archivosWidget,
        ),
      ),
    );
  }
}
