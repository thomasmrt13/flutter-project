import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core
import 'package:flutter/material.dart';
import 'package:tekhub/firebase_options.dart';
import 'package:tekhub/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TekHub',
      theme: ThemeData(
        primaryColor: const Color(0xFF272727),
        primaryColorLight: Colors.white,
        fontFamily: 'Raleway',
      ),
      initialRoute: 'splash',
      routes: getApplicationRoutes(),
    );
  }
}
