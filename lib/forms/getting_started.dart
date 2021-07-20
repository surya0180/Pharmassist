import 'package:flutter/material.dart';
import 'package:pharmassist/forms/user_form.dart';

class GettingStarted extends StatefulWidget {
  const GettingStarted({Key key}) : super(key: key);

  static const routeName = '/getting-started';

  @override
  _GettingStartedState createState() => _GettingStartedState();
}

class _GettingStartedState extends State<GettingStarted> {
  int _pageNo = 0;

  void _nextPage() {
    setState(() {
      _pageNo = 1;
    });
  }

  void _prevPage() {
    setState(() {
      _pageNo = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: AnimatedContainer(
          curve: Curves.easeIn,
          duration: Duration(milliseconds: 300),
          height: _pageNo == 0
              ? MediaQuery.of(context).size.height * 0.50
              : MediaQuery.of(context).size.height * 0.55,
          width: MediaQuery.of(context).size.width * 0.9,
          padding: EdgeInsets.all(15),
          constraints: BoxConstraints(
            minHeight: 320,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                blurRadius: 13,
                offset: Offset(6, 7),
                spreadRadius: 1,
                color: Colors.blueGrey,
              ),
            ],
          ),
          child: _pageNo == 0
              ? UserFormPart1(_nextPage)
              : UserFormPart2(_prevPage),
        ),
      ),
    );
  }
}
