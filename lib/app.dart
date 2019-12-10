import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:gtbuddy/blocs/location_bloc.dart';
import 'package:gtbuddy/blocs/station_bloc.dart';
import 'package:gtbuddy/ui/dashboard.dart';
import 'package:gtbuddy/ui/splash_screen.dart';
import 'package:flutter/material.dart';

class GtBuddyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((c) => LocationBloc()),
        Bloc((c) => StationBloc())
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
