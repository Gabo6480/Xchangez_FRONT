import 'package:flutter/material.dart';

class CustomItemCard extends StatefulWidget {
  CustomItemCard({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomItemCardState();
}

class _CustomItemCardState extends State<CustomItemCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://techcrunch.com/wp-content/uploads/2020/05/DSC00537.jpg?w=1390&crop=1'),
                        ),
                      ),
                    )),
                isHovered
                    ? AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          alignment: Alignment.topRight,
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
                        ))
                    : Container(),
              ],
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "\$42069",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                )),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                child: Text(
                  "Tu corazón",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(fontSize: 12, height: 2, color: Colors.black54),
                )),
          ]),
      onTap: () {},
      onHover: (value) => setState(() {
        isHovered = value;
      }),
    ));
  }
}
