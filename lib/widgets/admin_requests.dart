import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RequestsWidget extends StatefulWidget {
  @override
  _RequestsWidgetState createState() => _RequestsWidgetState();
}

class _RequestsWidgetState extends State<RequestsWidget> {
  String _chosenValue;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('pharmacist requests')
          .snapshots(),
      builder: (ctx, pharmSnapShot) {
        if (pharmSnapShot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('pharmacist requests')
                .snapshots(),
            builder: (ctx, storeSnapShot) {
              if (storeSnapShot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final pharmReqs = pharmSnapShot.data.docs;
              final medicReqs = storeSnapShot.data.docs;
              return Column(
                children: [
                  DropdownButton<String>(
                    focusColor: Colors.white,
                    value: _chosenValue,
                    //elevation: 5,
                    style: TextStyle(color: Colors.white),
                    iconEnabledColor: Colors.black,
                    items: <String>[
                      'Android',
                      'IOS',
                      'Flutter',
                      'Node',
                      'Java',
                      'Python',
                      'PHP',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    hint: Text(
                      "Please choose a langauage",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        _chosenValue = value;
                      });
                    },
                  ),
                ],
              );
            });
      },
    );
  }
}
