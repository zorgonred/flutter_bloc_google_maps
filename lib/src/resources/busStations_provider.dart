import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
//...
Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
  return rootBundle.loadString(assetsPath)
      .then((jsonStr) => jsonDecode(jsonStr));
}