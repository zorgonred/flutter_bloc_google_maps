import 'package:flutter/material.dart';
import 'package:gtbuddy/src/ui/splashScreen.dart';


class GtBuddyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GTBuddy',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
