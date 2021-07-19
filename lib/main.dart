import 'package:flutter/material.dart';
import 'package:pharmassist/helpers/MyThemeData.dart';
import 'package:pharmassist/screens/auth_screen.dart';
import 'package:pharmassist/screens/chat_screen.dart';
import 'package:pharmassist/screens/tab_screen.dart';

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
      home: signIn ? AuthScreen() : TabScreen(),
      routes: {
        AuthScreen.routeName: (ctx) => AuthScreen(),
        TabScreen.routeName: (ctx) => TabScreen(),
        ChatScreen.routeName: (ctx) => ChatScreen(),
      },
    );
  }
}
