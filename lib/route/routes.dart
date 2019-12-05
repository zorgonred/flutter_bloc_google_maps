import 'package:flutter/material.dart';

class CustomRouter {
  static pushReplacementNamed(BuildContext context, String router) {
    Navigator.of(context).pushReplacementNamed(router);
  }

  static push(BuildContext context, String router) {
    Navigator.of(context).pushNamed(router);
  }

  static pushReplacement(BuildContext context, Widget page) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => page));
  }
}
