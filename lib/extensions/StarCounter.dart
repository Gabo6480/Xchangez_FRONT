import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StarCounter extends StatelessWidget {
  StarCounter(
      {Key key, this.score, this.mainAxisAlignment = MainAxisAlignment.start})
      : super(key: key);

  final double score;
  final List<Widget> stars = List();
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    double _score = score;
    for (int i = 0; i < 5; i++) {
      stars.add(Icon(
        _score >= 1.0
            ? Icons.star
            : (_score >= 0.25 ? Icons.star_half : Icons.star_outline),
        color: theme.accentColor,
      ));
      _score -= 1.0;
    }

    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: stars +
          [
            SizedBox(
              width: 8,
            ),
            Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: BorderRadius.circular(50)),
                child: Text(
                  score.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ))
          ],
    );
  }
}
