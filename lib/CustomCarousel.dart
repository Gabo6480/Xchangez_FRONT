import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCarousel extends StatefulWidget {
  CustomCarousel({Key key, this.height, this.autoPlay = true, this.items})
      : super(key: key);

  final double height;
  final bool autoPlay;
  final List<Widget> items;

  @override
  State<StatefulWidget> createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  final CarouselController _controller = CarouselController();
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    double iconSize = 50;

    List<Widget> _items;

    if (widget.items != null)
      _items = widget.items;
    else {
      _items = List();
      for (int i = 0; i < 8; i++) {
        _items.add(Container(
          width: double.infinity,
          color: Colors.red,
          child: Text(i.toString()),
        ));
      }
    }

    return Stack(alignment: Alignment.center, children: [
      CarouselSlider(
          carouselController: _controller,
          options: CarouselOptions(
              height: widget.height,
              autoPlay: widget.autoPlay,
              enlargeCenterPage: false,
              viewportFraction: 1,
              autoPlayInterval: Duration(seconds: 6),
              onPageChanged: (idx, r) {
                setState(() {
                  _current = idx;
                });
              }),
          items: _items),
      _items.length > 1
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(10)),
                    child: InkWell(
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white,
                        size: iconSize,
                      ),
                      onTap: () => _controller.previousPage(),
                    )),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(10)),
                    child: InkWell(
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                          size: iconSize,
                        ),
                        onTap: () => _controller.nextPage()))
              ],
            )
          : SizedBox(),
      Positioned(
        bottom: 5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _items.map((e) {
            int index = _items.indexOf(e);
            bool isSelected = _current == index;
            return IconButton(
              iconSize: isSelected ? 13 : 12,
              icon: Icon(
                Icons.circle,
                color: isSelected
                    ? Color.fromRGBO(0, 0, 0, 0.6)
                    : Color.fromRGBO(0, 0, 0, 0.3),
              ),
              onPressed: () {
                setState(() {
                  _controller.animateToPage(index);
                });
              },
            );
          }).toList(),
        ),
      )
    ]);
  }
}
