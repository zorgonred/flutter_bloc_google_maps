import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtbuddy/ui/dashBoard.dart';
import 'package:gtbuddy/ui/splash_screen.dart';
import 'blocs/dashboard/dashboard_bloc.dart';
import 'blocs/location_list/location_list_bloc.dart';

class GtBuddyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocationListBloc>(
          create: (BuildContext context) => LocationListBloc(),
        ),
        BlocProvider<DashboardSavedBloc>(
          create: (BuildContext context) => DashboardSavedBloc(),
        ),
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
