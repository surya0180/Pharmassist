import 'package:flutter/material.dart';
import 'package:pharmassist/forms/getting_started.dart';
import 'package:pharmassist/forms/medical_request_form.dart';
import 'package:pharmassist/forms/pharmacist_request_form.dart';
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
      home: signIn ? AuthScreen() : GettingStarted(),
      routes: {
        AuthScreen.routeName: (ctx) => AuthScreen(),
        GettingStarted.routeName: (ctx) => GettingStarted(),
        TabScreen.routeName: (ctx) => TabScreen(),
        ChatScreen.routeName: (ctx) => ChatScreen(),
        MedicalRequestForm.routeName: (ctx) => MedicalRequestForm(),
        PharmacistRequestForm.routeName: (ctx) => PharmacistRequestForm(),
      },
    );
  }
}
