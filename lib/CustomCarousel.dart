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
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            child: Icon(
              Icons.arrow_left,
              color: Colors.white,
              size: 80,
            ),
            onTap: () => _controller.previousPage(),
          ),
          InkWell(
              child: Icon(
                Icons.arrow_right,
                color: Colors.white,
                size: 80,
              ),
              onTap: () => _controller.nextPage())
        ],
      ),
      Container(
        padding: EdgeInsets.all(8),
        alignment: Alignment.bottomCenter,
        height: widget.height,
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
