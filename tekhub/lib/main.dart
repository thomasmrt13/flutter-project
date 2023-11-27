import 'package:flutter/material.dart';
import 'package:tekhub/routes/routes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TekHub',
      theme: ThemeData(
        primaryColor: const Color(0xFF5956E9),
        primaryColorLight: Colors.white,
        fontFamily: 'Raleway',
      ),
      initialRoute: 'auth',
      routes: getApplicationRoutes(),
    );
  }
}
