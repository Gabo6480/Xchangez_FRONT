import 'package:flutter/cupertino.dart';

class CircleImage extends StatelessWidget {
  CircleImage(
      {Key key, this.size = 50, this.image, this.border, this.boxShadow})
      : super(key: key);

  final double size;
  final BoxBorder border;
  final List<BoxShadow> boxShadow;
  final ImageProvider<Object> image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: border,
            boxShadow: boxShadow,
            image: DecorationImage(fit: BoxFit.cover, image: image)),
      ),
    );
  }
}
