import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HoverText extends StatefulWidget {
  HoverText(this.text, {Key key, this.style, this.onTap}) : super(key: key);

  final String text;
  final Function onTap;
  final TextStyle style;

  @override
  State<StatefulWidget> createState() => _HoverTextState();
}

class _HoverTextState extends State<HoverText> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    TextStyle _style = widget.style.copyWith(
        decoration:
            (isHovered || widget.style.decoration == TextDecoration.underline)
                ? TextDecoration.underline
                : TextDecoration.none);

    return InkWell(
      child: Text(
        widget.text,
        style: _style,
      ),
      onHover: (v) => setState(() {
        isHovered = v;
      }),
      onTap: widget.onTap,
    );
  }
}
