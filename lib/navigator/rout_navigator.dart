import 'package:flutter/material.dart';
import 'package:lkarnet/screens/auth/login.dart';
import 'package:lkarnet/screens/auth/register.dart';
import 'package:lkarnet/screens/home.dart';
import 'package:lkarnet/screens/splash.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    // final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashPage());
      case '/loginPage':
        return MaterialPageRoute(
            builder: (_) => LoginPage(), maintainState: false);
      case '/registerPage':
        return MaterialPageRoute(
          builder: (_) => RegisterPage(),
        );
      case '/home':
        return MaterialPageRoute(
          builder: (_) => HomePage(),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
