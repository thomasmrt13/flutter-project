import 'package:flutter/material.dart';
import 'package:tekhub/screens/card_screen.dart';
import 'package:tekhub/screens/forget_password_screen.dart';
import 'package:tekhub/screens/home_screen.dart';
import 'package:tekhub/screens/login_screen.dart';
import 'package:tekhub/screens/register_screen.dart';
import 'package:tekhub/screens/splash_screen.dart';
import 'package:tekhub/widgets/profile_widget.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext contex) => const Home(),
    'splash': (BuildContext contex) => const Splash(),
    'login': (BuildContext contex) => Login(),
    'register': (BuildContext contex) => Register(),
    'forget-password': (BuildContext contex) => ForgetPassword(),
    'card-information': (BuildContext contex) => const CardPage(),
    'profile': (BuildContext contex) => const ProfilePage(),
  };
}
