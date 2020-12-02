import 'package:Xchangez/model/Valoracion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ValoracionNewForm extends StatefulWidget {
  ValoracionNewForm(this.user, {Key key}) : super(key: key);

  int user;

  @override
  State<StatefulWidget> createState() => ValoracionNewFormState();
}

class ValoracionNewFormState extends State<ValoracionNewForm> {
  Valoracion newValoracion;

  @override
  void initState() {
    super.initState();

    newValoracion = Valoracion();

    _commentController = TextEditingController(text: newValoracion.comentario)
      ..addListener(() {
        newValoracion.comentario = _commentController.text;
      });
  }

  Valoracion save() {
    newValoracion.idUsuarioValorado = widget.user;
    return newValoracion;
  }

  var _commentController;
  final List<Widget> stars = List();
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    stars.clear();

    int _score = newValoracion.cantidad;
    for (int i = 0; i < 5; i++) {
      stars.add(IconButton(
        icon: Icon(
          _score >= 1 ? Icons.star : Icons.star_outline,
          color: theme.accentColor,
        ),
        onPressed: () {
          newValoracion.cantidad = i + 1;
          setState(() {});
        },
      ));
      _score -= 1;
    }

    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: stars,
          ),
          TextFormField(
            controller: _commentController,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(left: 8),
                labelText: "Comentario"),
            onSaved: (input) => newValoracion.comentario = input,
          ),
        ],
      ),
    );
  }
}
