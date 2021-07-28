import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pharmassist/forms/medical_request_form.dart';
import 'package:pharmassist/forms/pharmacist_request_form.dart';
import 'package:pharmassist/helpers/MyThemeData.dart';
import 'package:pharmassist/providers/comment_provider.dart';
import 'package:pharmassist/providers/feed_provider.dart';
import 'package:pharmassist/providers/google_sign_in.dart';
import 'package:pharmassist/screens/auth_screen.dart';
import 'package:pharmassist/screens/chat_screen.dart';
import 'package:pharmassist/screens/comments_screen.dart';
import 'package:pharmassist/screens/feed_detail_screeen.dart';
import 'package:pharmassist/screens/store_detail_screen.dart';
import 'package:pharmassist/screens/store_screen.dart';
import 'package:pharmassist/screens/tab_screen.dart';
import 'package:pharmassist/widgets/new_feed_form.dart';
import 'package:provider/provider.dart';
import 'providers/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const signIn = true;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => FeedProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CommentProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => GoogleSignInProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Pharmassist',
        theme: MyThemeData,
        home: AuthPage(),
        routes: {
          AuthScreen.routeName: (ctx) => AuthScreen(),
          TabScreen.routeName: (ctx) => TabScreen(),
          ChatScreen.routeName: (ctx) => ChatScreen(),
          MedicalRequestForm.routeName: (ctx) => MedicalRequestForm(),
          PharmacistRequestForm.routeName: (ctx) => PharmacistRequestForm(),
          NewFeedForm.routeName: (ctx) => NewFeedForm(),
          FeedDetailScreen.routeName: (ctx) => FeedDetailScreen(),
          StoreScreen.routeName: (ctx) => StoreScreen(),
          StoreDetailScreen.routeName: (ctx) => StoreDetailScreen(),
          CommentScreen.routeName: (ctx) => CommentScreen(),
        },
      ),
    );
  }
}

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("something went wrong"),
              );
            } else if (snapshot.hasData) {
              return TabScreen();
            } else {
              return AuthScreen();
            }
          },
        ),
      );
}
