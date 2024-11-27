import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/welcome.dart';
import 'screens/information.dart';
import 'screens/login.dart';
import 'screens/connection.dart';
import 'screens/start.dart';
import 'screens/signup.dart';
import 'screens/course.dart';
import 'screens/account.dart';
import 'screens/address.dart';
import 'screens/about.dart';

import 'package:learnr/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Set initial route
      initialRoute: '/',
      // Define routes
      routes: {
        '/': (context) => welcome(),
        '/info': (context) => information(),
        '/login': (context) => login(),
        '/establish': (context) => connection(),
        '/start': (context) => start(),
        '/signup': (context) => signup(),
        '/courses': (context) => course(),
        '/account': (context) => account(),
        '/address': (context) => address(),
        '/about': (context) => about()
      },
    );
  }
}
