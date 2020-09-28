import 'package:flutter/material.dart';

class CustomItemCard extends StatefulWidget {
  CustomItemCard({Key key, this.cardWidth}) : super(key: key);

  final double cardWidth;

  @override
  State<StatefulWidget> createState() => _CustomItemCardState();
}

class _CustomItemCardState extends State<CustomItemCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(
      child: Column(children: [
        Stack(
          children: [
            Container(
              width: widget.cardWidth * .9,
              height: widget.cardWidth * .9,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/0/01/Pocky-Sticks.jpg/1920px-Pocky-Sticks.jpg'),
                ),
              ),
            ),
            isHovered
                ? Container(
                    alignment: Alignment.topRight,
                    width: widget.cardWidth * .9,
                    height: widget.cardWidth * .9,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black38, Color(0x0E000000)]),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.chat_bubble_outline_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  )
                : Container(),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "\$42069",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "Tu corazón",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12, height: 2),
              )
            ],
          ),
        )
      ]),
      onTap: () {},
      onHover: (value) => setState(() {
        isHovered = value;
      }),
    ));
  }
}
