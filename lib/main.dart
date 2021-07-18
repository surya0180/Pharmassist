import 'package:flutter/material.dart';
import 'package:pharmassist/helpers/MyThemeData.dart';
import 'package:pharmassist/screens/auth_screen.dart';
import 'package:pharmassist/screens/my_home_page_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const signIn = true;
    return MaterialApp(
        title: 'Pharmassist',
        theme: MyThemeData,
        home: signIn ? AuthScreen() : MyHomePage(),
        routes: {
          AuthScreen.routeName: (ctx) => AuthScreen(),
          MyHomePage.routeName: (ctx) => MyHomePage(),
        });
  }
}
