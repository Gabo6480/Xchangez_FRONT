import 'package:Xchangez/model/Publicacion.dart';
import 'package:Xchangez/product/ProductItemPage.dart';
import 'package:Xchangez/services/api.publicacion.dart';
import 'package:Xchangez/services/api.services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomItemCard extends StatefulWidget {
  CustomItemCard(this.post, {Key key, this.updateParent})
      : this.isLoggedUser = APIServices.isLoggedUserId(post.idUsuario),
        super(key: key);

  final Publicacion post;
  final Function updateParent;

  final bool isLoggedUser;

  @override
  State<StatefulWidget> createState() => _CustomItemCardState();
}

class _CustomItemCardState extends State<CustomItemCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                        AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(widget.post.thumbnail),
                                ),
                              ),
                            )),
                        widget.post.esTrueque
                            ? Positioned(
                                bottom: -10,
                                right: 5,
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: theme.accentColor,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Icon(
                                    Icons.swap_calls,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : SizedBox(),
                      ] +
                      (widget.isLoggedUser
                          ? [
                              Positioned(
                                top: 5,
                                right: 5,
                                child: InkWell(
                                    child: Container(
                                      width: 25,
                                      height: 25,
                                      decoration: BoxDecoration(
                                          color: Colors.blueAccent,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black87,
                                                blurRadius: 1,
                                                offset: Offset(1, 1))
                                          ]),
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    ),
                                    onTap: () {
                                      print("edit");
                                    }),
                              ),
                              Positioned(
                                top: 5,
                                right: 35,
                                child: InkWell(
                                    child: Container(
                                      width: 25,
                                      height: 25,
                                      decoration: BoxDecoration(
                                          color: Colors.redAccent,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black87,
                                                blurRadius: 1,
                                                offset: Offset(1, 1))
                                          ]),
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    ),
                                    onTap: () {
                                      PublicacionServices.deletePost(
                                          widget.post.id);
                                      if (widget.updateParent != null)
                                        widget.updateParent();
                                    }),
                              ),
                              widget.post.esBorrador
                                  ? Positioned(
                                      top: 5,
                                      left: 5,
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.greenAccent,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Icon(
                                          Icons.drafts,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                            ]
                          : [SizedBox()]),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      widget.post.precio > 0
                          ? "\$" + widget.post.precio.toString()
                          : (widget.post.esTrueque ? "TRUEQUE" : "GRATIS"),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    )),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      widget.post.titulo,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )),
                Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                    child: Text(
                      DateFormat('dd/MM/yyyy').format(widget.post.fechaAlta),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 12, height: 2, color: Colors.black54),
                    )),
              ]),
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_context) => ProductItemPage(widget.post))),
          onHover: (value) => setState(() {
            isHovered = value;
          }),
        ));
  }
}
