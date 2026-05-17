// ignore_for_file: annotate_overrides

import 'package:cubitproject/Screens/Chat_Screen.dart';
import 'package:cubitproject/Screens/Home_Screen.dart';
import 'package:cubitproject/Screens/Login_Screen.dart';
import 'package:cubitproject/Screens/Register_Screen.dart';
import 'package:cubitproject/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  MyApp({super.key});

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: _auth.currentUser != null
          ? HomeScreen.screenRoute
          : LoginScreen.screenRoute,
      routes: {
        LoginScreen.screenRoute: (context) => LoginScreen(),
        RegisterScreen.screenRoute: (context) => RegisterScreen(),
        HomeScreen.screenRoute: (context) =>
            HomeScreen(currentUser: _auth.currentUser!),
      },
    );
  }
}
