import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_app/screens/dashboardpage.dart';
import 'package:login_app/screens/homepage.dart';
import 'package:login_app/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "splash_screen",
        routes: {
          "/": (context) => Homepage(),
          "dashboardpage": (context) => Dashboard(),
          "splash_screen": (context) => IntroScreen(),
        }),
  );
}
