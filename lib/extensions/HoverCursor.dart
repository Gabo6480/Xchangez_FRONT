import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'dart:html' as html;

class HoverCursor extends MouseRegion {
  static final appContainer =
      html.window.document.querySelectorAll('flt-glass-pane')[0];
  HoverCursor({Widget child})
      : super(
            onHover: (PointerHoverEvent evt) {
              appContainer.style.cursor = 'pointer';
            },
            onExit: (PointerExitEvent evt) {
              appContainer.style.cursor = 'default';
            },
            child: child);
}
