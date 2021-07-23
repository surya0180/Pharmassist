import 'package:flutter/material.dart';
import 'package:pharmassist/forms/getting_started.dart';
import 'package:pharmassist/forms/medical_request_form.dart';
import 'package:pharmassist/forms/pharmacist_request_form.dart';
import 'package:pharmassist/helpers/MyThemeData.dart';
import 'package:pharmassist/screens/auth_screen.dart';
import 'package:pharmassist/screens/chat_screen.dart';
import 'package:pharmassist/screens/feed_detail_screeen.dart';
import 'package:pharmassist/screens/store_screen.dart';
import 'package:pharmassist/screens/tab_screen.dart';
import 'package:pharmassist/widgets/new_feed_form.dart';

import 'helpers/user_info.dart';

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
      home: signIn
          ? userInfo['isAddedInfo']
              ? GettingStarted()
              : AuthScreen()
          : TabScreen(),
      routes: {
        AuthScreen.routeName: (ctx) => AuthScreen(),
        TabScreen.routeName: (ctx) => TabScreen(),
        ChatScreen.routeName: (ctx) => ChatScreen(),
        MedicalRequestForm.routeName: (ctx) => MedicalRequestForm(),
        PharmacistRequestForm.routeName: (ctx) => PharmacistRequestForm(),
        NewFeedForm.routeName: (ctx) => NewFeedForm(),
        FeedDetailScreen.routeName: (ctx) => FeedDetailScreen(),
        StoreScreen.routeName: (ctx) => StoreScreen(),
      },
    );
  }
}
