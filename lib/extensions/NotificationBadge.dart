import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationBadge extends StatelessWidget {
  NotificationBadge(
      {Key key, this.child, this.notifications = 0, this.size = 9})
      : super(key: key);
  final Widget child;
  final int notifications;
  final double size;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Stack(
      children: [
        child,
        Positioned(
            right: 0,
            child: notifications > 0
                ? Container(
                    padding: EdgeInsets.all(1),
                    decoration: new BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    constraints: BoxConstraints(
                      minWidth: size,
                      minHeight: size,
                    ),
                    child: Text(
                      notifications < 100 ? notifications.toString() : "+99",
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: size,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                : SizedBox())
      ],
    );
  }
}
