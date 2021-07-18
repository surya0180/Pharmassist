import 'package:flutter/material.dart';
import 'package:pharmassist/screens/my_home_page_screen.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth-screen';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Authenticate"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            child: Center(
                child: Text(
              "Please get Signed in to proceed",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )),
          ),
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            child: OutlineButton(
              textColor: Colors.grey, // foreground
              onPressed: () {
                Navigator.of(context).pushNamed(MyHomePage.routeName);
              },
              child: Text('Sign in With Google'),
            ),
          ),
        ],
      ),
    );
  }
}
