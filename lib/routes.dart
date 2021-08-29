import 'package:flashchat/screens/chat.dart';
import 'package:flashchat/screens/login.dart';
import 'package:flashchat/screens/registration.dart';
import 'package:flashchat/screens/welcome.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static const ROUTE_HOME = '/';
  static const ROUTE_LOGIN = '/login';
  static const ROUTE_SIGNUP = '/registration';
  static const ROUTE_CHAT = '/chat';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ROUTE_LOGIN:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case ROUTE_SIGNUP:
        return MaterialPageRoute(builder: (context) => RegistrationScreen());
      case ROUTE_CHAT:
        return MaterialPageRoute(builder: (context) => ChatScreen());
      default:
        return MaterialPageRoute(builder: (context) => Welcome());
    }
  }
  static _screenArguments(settings, key) {
    return settings.arguments[key];
  }
}