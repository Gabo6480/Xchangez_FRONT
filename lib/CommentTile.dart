import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommentTile extends StatefulWidget {
  CommentTile({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CommentTileState();
}

class _CommentTileState extends State<CommentTile> {
  bool isHovered = false;
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.circle, size: 50),
      title: Text("Usuario Usañez",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "TEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT TEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT TEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT"),
          Divider(
            color: Colors.black26,
            thickness: 1,
          ),
          Container(
              padding: EdgeInsets.only(left: 15, bottom: 5),
              child: InkWell(
                child: Row(children: [
                  Text(
                    "5 respuestas",
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
              children: [
                ResponseTile(),
                ResponseTile(),
                ResponseTile(),
                ResponseTile(),
                ResponseTile(),
                ResponseTextFiled(),
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
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.circle, size: 50),
      title: Text("Respondiño Respondón",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      subtitle: Text("Respuesta responsiva directa"),
    );
  }
}

class ResponseTextFiled extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.circle, size: 50),
      title: TextField(
        maxLines:
            null, // Este null es requerido para la funcionalidad de expanción en overflow
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 8, bottom: 6),
          labelText: "Responder...",
          suffixIcon: IconButton(
            icon: Icon(Icons.send),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
