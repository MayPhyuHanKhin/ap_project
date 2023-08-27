import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'dashboard.dart';
import 'login.dart';
import 'signup.dart';
import 'welcomepage.dart';
import 'addnote.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Students Information Recording System',
      initialRoute: '/welcome', // Set the initial route to the welcome page
      routes: {
        '/welcome': (context) => WelcomePage(),
        '/Signup': (context) => SignUpPage(),
        '/Login': (context) => LogInPage(),
        '/home': (context) => Home(),
      },
    );
  }
}
