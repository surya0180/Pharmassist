import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmassist/widgets/request_item.dart';

class Dashboard extends StatefulWidget {
  static const routeName = '/dashboard';
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _value = 1;
  String RequestType = "pharm";
  var streamBuilder = FirebaseFirestore.instance
      .collection('pharmacist requests')
      .where('isDeleted', isEqualTo: true)
      .snapshots();
  void setValue(value) {
    if (value == 1) {
      setState(() {
        RequestType = "pharm";
        streamBuilder = FirebaseFirestore.instance
            .collection('pharmacist requests')
            .where('isDeleted', isEqualTo: true)
            .snapshots();
      });
    } else {
      setState(() {
        RequestType = "medic";
        streamBuilder = FirebaseFirestore.instance
            .collection('medical requests')
            .where('isDeleted', isEqualTo: true)
            .snapshots();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        titleSpacing: 0.0,
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
        title: Container(
          padding: EdgeInsets.all(15.0),
          child: Container(
            padding: EdgeInsets.only(left: 5),
            color: Colors.cyan,
            child: DropdownButton(
                value: _value,
                items: [
                  DropdownMenuItem(
                    child: Text(
                      "pharmacist requests",
                    ),
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
                  setValue(value);
                }),
          ),
        ),
      ),
      body: DeletedRequests(
        streamBuilder: streamBuilder,
        requestType: RequestType,
      ),
    );
  }
}

class DeletedRequests extends StatelessWidget {
  const DeletedRequests({
    Key key,
    @required this.streamBuilder,
    @required this.requestType,
  }) : super(key: key);

  final Stream<QuerySnapshot<Map<String, dynamic>>> streamBuilder;
  final String requestType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: StreamBuilder(
          stream: streamBuilder,
          builder: (ctx, pharmSnapShot) {
            if (pharmSnapShot.connectionState == ConnectionState.waiting) {
              print("line 199");
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            final pharmReqs = pharmSnapShot.data.docs;

            return ListView.builder(
                itemCount: pharmReqs.length,
                itemBuilder: (ctx, i) {
                  return RequestItem(
                    pharmReqs[i].data()['createdOn'],
                    pharmReqs[i].data()['about'],
                    pharmReqs[i].data()['request'],
                    pharmReqs[i].data()['userId'],
                    pharmReqs[i].data()['PhotoUrl'],
                    pharmReqs[i].data()['username'],
                    requestType,
                    pharmReqs[i].id,
                  );
                });
          }),
    );
  }
}
