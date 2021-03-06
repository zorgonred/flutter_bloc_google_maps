import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gtbuddy/utils/colour_pallete.dart';
import 'dashboard.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<Timer> _loadData() async {
    return new Timer(Duration(seconds: 5), _onDoneLoading);
  }

  _onDoneLoading() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(decoration: BoxDecoration(color: Pallete.appBarColor)),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/icons/splash_screen/BusIcon.png'),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
