import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminRequestScreen extends StatefulWidget {
  @override
  _AdminRequestScreenState createState() => _AdminRequestScreenState();
}

class _AdminRequestScreenState extends State<AdminRequestScreen> {
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('pharmacist requests')
                .snapshots(),
            builder: (ctx, pharmSnapShot) {
              if (pharmSnapShot.connectionState == ConnectionState.waiting) {
                print("line 199");
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              print("line 24");
              return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('medical requests')
                      .snapshots(),
                  builder: (ctx, storeSnapShot) {
                    if (storeSnapShot.connectionState ==
                        ConnectionState.waiting) {
                      print("line 29");
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    print("line 34");
                    final pharmReqs = pharmSnapShot.data.docs;
                    final medicReqs = storeSnapShot.data.docs;
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(20.0),
                          child: Container(
                            padding: EdgeInsets.only(left: 5),
                            color: Colors.cyan,
                            child: DropdownButton(
                                value: _value,
                                items: [
                                  DropdownMenuItem(
                                    child: Text("pharmacist requests"),
                                    value: 1,
                                  ),
                                  DropdownMenuItem(
                                    child: Text("medical requests"),
                                    value: 2,
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _value = value;
                                  });
                                }),
                          ),
                        ),
                        (_value == 1)
                            ? ListView.builder(
                                itemCount: pharmReqs.length,
                                itemBuilder: (ctx, i) {},
                              )
                            : ListView.builder(
                                itemCount: medicReqs.length,
                                itemBuilder: (ctx, i) {},
                              )
                      ],
                    );
                  });
            }),
      ),
    );
  }
}
