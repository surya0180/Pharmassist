import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    print('I am in welcome screen');
    return Scaffold(
      body: Center(
        child: AnimatedContainer(
          child: const FlutterLogo(size: 75),
          curve: Curves.fastOutSlowIn,
          duration: Duration(milliseconds: 300),
        ),
      ),
    );
  }
}
