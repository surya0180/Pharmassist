import 'package:flutter/material.dart';
import 'package:pharmassist/forms/getting_started.dart';
import 'package:pharmassist/screens/tab_screen.dart';

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
          Image.asset(
            'assets/images/splashlogo.png',
            height: 150,
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Center(
              child: Text(
                "Please get Signed in to proceed",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Theme.of(context).primaryColorDark),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: SizedBox(
              width: 200,
              child: RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),

                color: Colors.orange,
                textColor: Colors.white, // foreground
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(GettingStarted.routeName);
                },
                child: Row(
                  children: [
                    Text(
                      'Sign in With Google',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
