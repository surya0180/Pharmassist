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
    return MaterialApp(
      title: 'Pharmassist',
      theme: MyThemeData,
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabScreen(),
        AuthScreen.routeName: (ctx) => AuthScreen(),
        ChatScreen.routeName: (ctx) => ChatScreen(),
      },
    );
  }
}
