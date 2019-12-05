import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:gtbuddy/ui/dashBoard.dart';
import 'package:gtbuddy/ui/splashScreen.dart';

class GtBuddyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        //add blocks
//        Bloc((c) => DashboardBloc())
      ],
      child: MaterialApp(
        title: 'GTBuddy',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'BeVietnam',
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(
                builder: (context) => SplashScreen(),
                settings: settings,
              );
            case '/dashboard':
              return MaterialPageRoute(
                builder: (context) => HomeScreen(),
                settings: settings,
              );
            default:
              return null;
          }
        },
      ),
    );
  }
}
