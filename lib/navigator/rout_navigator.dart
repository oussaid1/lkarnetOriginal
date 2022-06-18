import 'package:flutter/material.dart';
import 'package:lkarnet/root.dart';
import 'package:lkarnet/screens/auth/login.dart';
import 'package:lkarnet/screens/auth/signup.dart';
import 'package:lkarnet/screens/home.dart';
import 'package:lkarnet/screens/splash.dart';

class RouteGenerator {
  static const String root = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String splash = '/splash';
  static const String error = '/error';
  static const String notFound = '*';
  static const String payment = '/payment';
  static const String dashboard = '/dashboard';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    // final args = settings.arguments;
    switch (settings.name) {
      case root:
        return MaterialPageRoute(builder: (_) => SplashPage());
      case home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case signup:
        return MaterialPageRoute(builder: (_) => SignUpPage());
      case splash:
        return MaterialPageRoute(builder: (_) => SplashPage());
      case error:
        return _errorRoute();
      // case notFound:
      //   return MaterialPageRoute(builder: (_) => NotFoundPage());
      // case payment:
      //   return MaterialPageRoute(builder: (_) => PaymentPage());
      // case dashboard:
      //   return MaterialPageRoute(builder: (_) => DashboardPage());
      default:
        return MaterialPageRoute(builder: (_) => Root());
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
