import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pharmassist/forms/medical_request_form.dart';
import 'package:pharmassist/forms/pharmacist_request_form.dart';
import 'package:pharmassist/helpers/theme/MyThemeData.dart';
import 'package:pharmassist/providers/auth/admin-provider.dart';
import 'package:pharmassist/providers/comments/comment_provider.dart';
import 'package:pharmassist/providers/feed/feed_provider.dart';
import 'package:pharmassist/providers/auth/google_sign_in.dart';
import 'package:pharmassist/providers/notification-provider.dart';
import 'package:pharmassist/providers/profileEditStatus.dart';
import 'package:pharmassist/screens/admin/request_detail_screen.dart';
import 'package:pharmassist/screens/tabs/auth_screen.dart';
import 'package:pharmassist/screens/chat/chat_screen.dart';
import 'package:pharmassist/screens/admin/dashboard_screen.dart';
import 'package:pharmassist/screens/feeds/feed_detail_screeen.dart';
import 'package:pharmassist/screens/tabs/profile_screen.dart';
import 'package:pharmassist/screens/stores/store_detail_screen.dart';
import 'package:pharmassist/screens/stores/store_screen.dart';
import 'package:pharmassist/screens/tab_screen.dart';
import 'package:pharmassist/screens/tabs/request_screen.dart';
import 'package:pharmassist/widgets/feed/new_feed_form.dart';
import 'package:provider/provider.dart';
import 'providers/store.dart';
import 'providers/auth/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          create: (ctx) => AdminProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => GoogleSignInProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => StoreProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => NotificationProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ProfileEditStatus(),
        ),
      ],
      child: MaterialApp(
        title: 'Pharmassist',
        theme: MyThemeData,
        home: AuthPage(),
        routes: {
          AuthScreen.routeName: (ctx) => AuthScreen(),
          ProfilePage.routeName: (ctx) => ProfilePage(),
          TabScreen.routeName: (ctx) => TabScreen(),
          ChatScreen.routeName: (ctx) => ChatScreen(),
          MedicalRequestForm.routeName: (ctx) => MedicalRequestForm(),
          PharmacistRequestForm.routeName: (ctx) => PharmacistRequestForm(),
          NewFeedForm.routeName: (ctx) => NewFeedForm(),
          FeedDetailScreen.routeName: (ctx) => FeedDetailScreen(),
          StoreScreen.routeName: (ctx) => StoreScreen(),
          StoreDetailScreen.routeName: (ctx) => StoreDetailScreen(),
          Dashboard.routeName: (ctx) => Dashboard(),
          RequestDetailScreen.routeName: (ctx) => RequestDetailScreen(),
          RequestScreen.routeName: (ctx) => RequestScreen(),
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
