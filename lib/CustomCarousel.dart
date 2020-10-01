import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCarousel extends StatefulWidget {
  CustomCarousel({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double carouselHeight = width > 800 ? width * 0.25 : 200;

    return Stack(alignment: Alignment.center, children: [
      CarouselSlider.builder(
        itemCount: 5,
        carouselController: _controller,
        options: CarouselOptions(
            height: carouselHeight,
            autoPlay: true,
            enlargeCenterPage: false,
            viewportFraction: 1,
            autoPlayInterval: Duration(seconds: 6)),
        itemBuilder: (context, index) {
          return Container(
            width: double.infinity,
            color: Colors.red,
            child: Text(index.toString()),
          );
        },
      ),
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
      )
    ]);
  }
}
