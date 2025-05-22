import 'package:flutter/material.dart';
import 'package:app1/config/theme.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: appTheme,
    initialRoute: '/login',
    routes: {
      '/login': (context) => Home(),         
      '/signup': (context) => SignupScreen(), 
      '/home': (context) => HomeScreen(),     
    },
  ));
}
