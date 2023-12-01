import 'package:flutter/material.dart';
import 'package:tekhub/screens/home_screen.dart';
import 'package:tekhub/screens/login_screen.dart';
import 'package:tekhub/screens/register_screen.dart';
import 'package:tekhub/screens/splash_screen.dart';
import 'package:tekhub/screens/cart.screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext contex) => const Home(),
    'splash': (BuildContext contex) => const Splash(),
    'login': (BuildContext contex) => const Login(),
    'register': (BuildContext contex) => const Register(),
    'cart': (BuildContext contex) => Cart(),
  };
}
