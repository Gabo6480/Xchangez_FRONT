import 'package:Xchangez/extensions/CircleImage.dart';
import 'package:Xchangez/extensions/HoverText.dart';
import 'package:Xchangez/model/Comentario.dart';
import 'package:Xchangez/model/Usuario.dart';
import 'package:Xchangez/services/api.comentario.dart';
import 'package:Xchangez/services/api.services.dart';
import 'package:Xchangez/user/UserPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CommentTile extends StatefulWidget {
  CommentTile(this.comment, this.postId, this.updateParent, {Key key})
      : this.isLoggedUser = APIServices.isLoggedUserId(comment.idUsuario),
        super(key: key);
  final Comentario comment;
  final int postId;
  final Function updateParent;

  final bool isLoggedUser;

  @override
  State<StatefulWidget> createState() => _CommentTileState();
}

class _CommentTileState extends State<CommentTile> {
  bool isHovered = false;
  bool isOpen = false;

  List<Widget> respuestas = List();

  @override
  Widget build(BuildContext context) {
    respuestas.clear();
    widget.comment.comentarios.forEach((element) {
      respuestas.add(ResponseTile(element, widget.updateParent));
    });

    return ListTile(
      leading: CircleImage(
        image: NetworkImage(widget.comment.rutaImagenAvatar),
      ),
      trailing: widget.isLoggedUser
          ? IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.redAccent,
              ),
              onPressed: () {
                ThemeData theme = Theme.of(context);
                Alert(
                    title: "¿Está seguro que desea eliminar el comentario: " +
                        widget.comment.contenido +
                        "?",
                    desc: "Este es un cambio permanente.",
                    context: context,
                    type: AlertType.warning,
                    buttons: [
                      DialogButton(
                          color: theme.primaryColor,
                          child: Text(
                            "Aceptar",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () async {
                            if (await ComentarioServices.delete(
                                widget.comment.id)) {
                              Navigator.pop(context);
                              if (widget.updateParent != null)
                                widget.updateParent();
                            }
                          }),
                      DialogButton(
                        color: Colors.redAccent,
                        child: Text(
                          "Cancelar",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () => Navigator.pop(context),
                      )
                    ]).show();
              },
            )
          : SizedBox(),
      title: Row(children: [
        HoverText(widget.comment.nombreCompleto,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_context) =>
                        UserPage(widget.comment.idUsuario)))),
        Text(
            "  -  " + DateFormat('dd/MM/yyyy').format(widget.comment.fechaAlta),
            style: TextStyle(fontSize: 12, color: Colors.grey))
      ]),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.comment.contenido),
          Divider(
            color: Colors.black26,
            thickness: 1,
          ),
          Container(
              padding: EdgeInsets.only(left: 15, bottom: 5),
              child: InkWell(
                child: Row(children: [
                  Text(
                    widget.comment.comentarios.isEmpty
                        ? "Responder"
                        : widget.comment.comentarios.length.toString() +
                            " respuestas",
                    style: TextStyle(
                        color: Colors.black,
                        decoration: isHovered
                            ? TextDecoration.underline
                            : TextDecoration.none),
                  ),
                  Icon(isOpen
                      ? Icons.arrow_drop_up_rounded
                      : Icons.arrow_drop_down_rounded)
                ]),
                onHover: (v) => setState(() {
                  isHovered = v;
                }),
                onTap: () => setState(() {
                  isOpen = !isOpen;
                }),
              )),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
                color: Color(0x10000000),
                borderRadius: BorderRadius.circular(10)),
            height: isOpen ? null : 0,
            child: Column(
              children: respuestas +
                  [
                    ResponseTextFiled(
                      APIServices.loggedInUser,
                      widget.postId,
                      widget.updateParent,
                      parentId: widget.comment.id,
                    ),
                    SizedBox(
                      height: 6,
                    )
                  ],
            ),
          )
        ],
      ),
    );
  }
}

class ResponseTile extends StatelessWidget {
  ResponseTile(this.comment, this.updateParent)
      : isLoggedUser = APIServices.isLoggedUserId(comment.idUsuario);

  final Comentario comment;
  final bool isLoggedUser;

  final Function updateParent;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleImage(
          image: NetworkImage(comment.rutaImagenAvatar),
        ),
        title: Row(children: [
          HoverText(comment.nombreCompleto,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_context) => UserPage(comment.idUsuario)))),
          Text("  -  " + DateFormat('dd/MM/yyyy').format(comment.fechaAlta),
              style: TextStyle(fontSize: 12, color: Colors.grey))
        ]),
        subtitle: Text(comment.contenido),
        trailing: isLoggedUser
            ? IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                ),
                onPressed: () {
                  ThemeData theme = Theme.of(context);
                  Alert(
                      title: "¿Está seguro que desea eliminar el comentario: " +
                          comment.contenido +
                          "?",
                      desc: "Este es un cambio permanente.",
                      context: context,
                      type: AlertType.warning,
                      buttons: [
                        DialogButton(
                            color: theme.primaryColor,
                            child: Text(
                              "Aceptar",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () async {
                              if (await ComentarioServices.delete(comment.id)) {
                                Navigator.pop(context);
                                if (updateParent != null) updateParent();
                              }
                            }),
                        DialogButton(
                          color: Colors.redAccent,
                          child: Text(
                            "Cancelar",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () => Navigator.pop(context),
                        )
                      ]).show();
                },
              )
            : SizedBox());
  }
}

class ResponseTextFiled extends StatelessWidget {
  ResponseTextFiled(this.usuario, this.postId, this.updateParent,
      {Key key, this.parentId = 0})
      : super(key: key);

  final Usuario usuario;
  final int parentId;
  final int postId;
  final Function updateParent;

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (usuario != null)
      return ListTile(
        leading: CircleImage(
          image: NetworkImage(usuario.imagenPerfil),
        ),
        title: TextField(
          controller: _controller,
          maxLines:
              null, // Este null es requerido para la funcionalidad de expanción en overflow
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 8, bottom: 6),
            labelText: "Responder...",
            suffixIcon: IconButton(
              icon: Icon(Icons.send),
              onPressed: () async {
                if (_controller.text.isNotEmpty) {
                  await ComentarioServices.create(Comentario(
                      idComentarioPadre: parentId,
                      idPublicacion: postId,
                      contenido: _controller.text));
                  updateParent();
                }
              },
            ),
          ),
        ),
      );
    else
      return Text("Necesitas haber ingresado para poder comentar");
  }
}
