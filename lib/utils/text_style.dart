import 'package:flutter/material.dart';

class AppStyles {
  static TextStyle Header({double size, Colors color, g}) {
    return TextStyle(color: Colors.grey, fontSize: size ?? 14.0);
  }

  static TextStyle Results({double size, Colors color, g}) {
    return TextStyle(color: Colors.black, fontSize: size ?? 14.0);
  }
}
