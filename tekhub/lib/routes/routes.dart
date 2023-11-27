import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tekhub/screens/login_screen.dart';
import 'package:tekhub/screens/register_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    'login': (BuildContext contex) => const Login(),
    'register': (BuildContext contex) => const Register(),
  };
}
