import 'package:flutter/material.dart';
import 'package:pharmassist/providers/auth/google_sign_in.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth-screen';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 20),
              child: Image.asset(
                'assets/images/splashlogo.png',
                height: device.height*0.185,
              ),
            ),
            Container(
              // width: double.maxFinite,
              child: SignInButton(
                Buttons.GoogleDark,
                text: "Sign up with Google",
                onPressed: () {
                  final authProvider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  authProvider.googleLogIn();
                  //   Navigator.of(context)
                  //       .pushReplacementNamed(TabScreen.routeName);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
