import 'package:flutter/material.dart';
import 'package:tekhub/screens/splash_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    'splash': (BuildContext contex) => const Splash(),
  };
}
