import 'package:Xchangez/product/CommentTile.dart';
import 'package:Xchangez/CustomCarousel.dart';
import 'package:Xchangez/extensions/CircleImage.dart';
import 'package:Xchangez/extensions/HoverText.dart';
import 'package:Xchangez/extensions/VideoPlayer.dart';
import 'package:Xchangez/model/Publicacion.dart';
import 'package:Xchangez/model/Usuario.dart';
import 'package:Xchangez/scaffold/CustomScaffold.dart';
import 'package:Xchangez/services/api.comentario.dart';
import 'package:Xchangez/services/api.publicacion.dart';
import 'package:Xchangez/services/api.services.dart';
import 'package:Xchangez/user/UserPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:intl/intl.dart';
import 'package:mime/mime.dart';

class ProductItemPage extends StatefulWidget {
  ProductItemPage(this.post, {Key key}) : super(key: key);

  final Publicacion post;

  @override
  State<StatefulWidget> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItemPage> {
  List<Widget> _caracteristicas = List();

  Usuario _poster = Usuario();

  @override
  void initState() {
    super.initState();

    PublicacionServices.addVisita(widget.post.id);

    widget.post.caracteristicas.forEach((key, value) {
      _caracteristicas.add(ListTile(
        title: Text(key,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        trailing: Text(value),
      ));
    });

    getPoster();

    setState(() {});
  }

  void getPoster() async {
    _poster = await APIServices.getUser(widget.post.idUsuario);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    double carousel = min(500, width * .85);

    return CustomScaffold(ListView(children: [
      Container(
        width: double.infinity,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(1.0, 0), //(x,y)
                blurRadius: 6.0,
              )
            ],
            borderRadius: BorderRadius.circular(20)),
        child: Wrap(
          //crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.spaceAround,
          children: [
            Container(
                width: carousel,
                child: FutureBuilder(
                  future: PublicacionServices.getFilesByPostId(widget.post.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.none &&
                            snapshot.hasData == null ||
                        snapshot.data == null)
                      return Text('Cargando...',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold));
                    else if (snapshot.data.isNotEmpty) {
                      List<Widget> _items = List();
                      snapshot.data.forEach((element) {
                        Widget newWidget =
                            lookupMimeType(element.ecstension).contains("image")
                                ? Image.network(element.ruta)
                                : VideoPlayerScreen(element.ruta);

                        _items.add(newWidget);
                      });

                      return CustomCarousel(
                        height: carousel,
                        autoPlay: false,
                        items: _items,
                      );
                    } else
                      return Text('Aquí no hay nada...',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold));
                  },
                )),
            Container(
              width: carousel,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(widget.post.titulo,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 28)),
                      subtitle: Text(
                          "Publicado el " +
                              DateFormat('dd/MM/yyyy')
                                  .format(widget.post.fechaAlta),
                          style: TextStyle(fontSize: 12)),
                    ),
                    ListTile(
                        title: Text(widget.post.precio > 0
                            ? ("\$" +
                                widget.post.precio.toString() +
                                (widget.post.esTrueque ? " o TRUEQUE" : ""))
                            : (widget.post.esTrueque ? "TRUEQUE" : "GRATIS"))),
                    ListTile(
                      title: Text("Dueño",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      subtitle: UserScoreCard(user: _poster),
                    ),
                    widget.post.estado != Estado.indefinido
                        ? ListTile(
                            title: Text("Estado",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            subtitle: Text(widget.post.estado == Estado.usado
                                ? "Usado"
                                : "Nuevo"),
                          )
                        : SizedBox(),
                    _caracteristicas.length > 0
                        ? ExpansionTile(
                            title: Text("Características",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            children: _caracteristicas)
                        : SizedBox(),
                    ListTile(
                      title: Text("Descripción",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      subtitle: Text(widget.post.descripcion),
                    ),
                  ]),
            )
          ],
        ),
      ),
      Container(
          width: double.infinity,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          //height: 100,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(1.0, 0), //(x,y)
                  blurRadius: 6.0,
                )
              ],
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              ResponseTextFiled(APIServices.loggedInUser, widget.post.id,
                  () => setState(() {})),
              Divider(
                color: Colors.black26,
                thickness: 1,
              ),
              FutureBuilder(
                future: ComentarioServices.getAllByPostId(widget.post.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.none &&
                          snapshot.hasData == null ||
                      snapshot.data == null)
                    return Text('Cargando...',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold));
                  else if (snapshot.data.isNotEmpty) {
                    List<Widget> _comentarios = List();
                    snapshot.data.forEach((element) {
                      _comentarios.add(CommentTile(
                          element, widget.post.id, () => setState(() {})));
                    });
                    return Column(
                      children: _comentarios,
                    );
                  } else
                    return Text('Aquí aún no hay comentarios...',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold));
                },
              )
            ],
          ))
    ]));
  }
}

class UserScoreCard extends StatelessWidget {
  UserScoreCard({Key key, this.user}) : super(key: key);

  final Usuario user;
  final List<Widget> stars = List();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    double _score = user.valoracion;
    for (int i = 0; i < 5; i++) {
      stars.add(Icon(
        _score >= 1.0
            ? Icons.star
            : (_score >= 0.25 ? Icons.star_half : Icons.star_outline),
        color: theme.accentColor,
      ));
      _score -= 1.0;
    }

    return ListTile(
      leading: CircleImage(
        image: NetworkImage(user.imagenPerfil),
      ),
      title: HoverText(user.nombre + " " + user.apellido,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_context) => UserPage(user.id)))),
      subtitle: Row(
        children: stars +
            [
              SizedBox(
                width: 8,
              ),
              Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.circular(50)),
                  child: Text(
                    user.valoracion.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ))
            ],
      ),
    );
  }
}
