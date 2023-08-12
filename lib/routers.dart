import 'package:allen/screens/HomeScreen.dart';
import 'package:allen/screens/LoginScreen.dart';
import 'package:flutter/material.dart';

class RouteGenerate {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const MaterialApp(
            home: Scaffold(
              body: Text('Error 404 Not Found!'),
            ),
          ),
        );
    }
  }
}
