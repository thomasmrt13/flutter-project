import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tekhub/firebase_options.dart';
import 'package:tekhub/provider/provider_listener.dart';
import 'package:tekhub/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Initialize Firebase
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  runApp(
    ChangeNotifierProvider<ProviderListener>(
      create: (BuildContext context) => ProviderListener(),
      child: const MyApp(),
    ),
  );
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
