import 'package:flutter/material.dart';
import 'package:pharmassist/screens/tab_screen.dart';

class UserFormPart1 extends StatefulWidget {
  const UserFormPart1(this.nextPage, {Key key}) : super(key: key);
  final Function nextPage;
  @override
  _UserFormPart1State createState() => _UserFormPart1State();
}

class _UserFormPart1State extends State<UserFormPart1> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: null,
      child: ListView(
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(10),
              child: Text(
                'Getting Started . .',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Full name',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(left: 12),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: InputBorder.none,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Registeration number',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(left: 12),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: InputBorder.none,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Renewal date',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(left: 12),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: InputBorder.none,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          ElevatedButton(
            onPressed: widget.nextPage,
            child: Text(
              'Next',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UserFormPart2 extends StatefulWidget {
  const UserFormPart2(this.prevPage, {Key key}) : super(key: key);
  final Function prevPage;
  @override
  _UserFormPart2State createState() => _UserFormPart2State();
}

class _UserFormPart2State extends State<UserFormPart2> {
  void _sendData() {
    widget.prevPage();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: null,
      child: ListView(
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Street',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(left: 12),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: InputBorder.none,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Town',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(left: 12),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: InputBorder.none,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'District',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(left: 12),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: InputBorder.none,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'State',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(left: 12),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: InputBorder.none,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          ElevatedButton(
            onPressed: widget.prevPage,
            child: Text(
              'Previous',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(TabScreen.routeName);
            },
            style: ElevatedButton.styleFrom(primary: Colors.green),
            child: Text(
              'Submit',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
