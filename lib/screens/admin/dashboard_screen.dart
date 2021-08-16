import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmassist/providers/auth/admin-provider.dart';
import 'package:pharmassist/screens/admin/medic_req_screen.dart';
import 'package:pharmassist/screens/admin/pharm_req_screen.dart';
import 'package:pharmassist/widgets/requests/request_item.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  static const routeName = '/dashboard';
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _value = 1;
  String RequestType = "pharm";
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AdminProvider>(context, listen: false).updateRequests(0);
    });

    super.initState();
  }

  final List<Map<String, Object>> _pages = [
    {'page': PharmReqScreen(true), 'title': 'Pharmassists'},
    {'page': MedicReqScreen(true), 'title': 'Medicals'},
  ];
  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setValue(index);
    setState(() {
      _selectedPageIndex = index;
    });
  }

  var streamBuilder = FirebaseFirestore.instance
      .collection('pharmacist requests')
      .orderBy('timestamp', descending: true)
      .where('isDeleted', isEqualTo: true)
      .snapshots();
  void setValue(value) {
    if (value == 0) {
      setState(() {
        RequestType = "pharm";
        streamBuilder = FirebaseFirestore.instance
            .collection('pharmacist requests')
            .orderBy('timestamp', descending: true)
            .where('isDeleted', isEqualTo: true)
            .snapshots();
      });
    } else {
      setState(() {
        RequestType = "medic";
        streamBuilder = FirebaseFirestore.instance
            .collection('medical requests')
            .orderBy('timestamp', descending: true)
            .where('isDeleted', isEqualTo: true)
            .snapshots();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Dashboard"),
            backgroundColor: Colors.lightGreenAccent[100],
            bottom: TabBar(
              indicatorColor: Colors.red,
              tabs: [
                Tab(
                  // icon: Icon(Icons.account_circle),
                  text: "Pharmassists",
                ),
                Tab(
                  // icon: Icon(Icons.store),
                  text: "Medicals",
                ),
              ],
            ),
          ),
          body: TabBarView(children: [
            PharmReqScreen(true),
            MedicReqScreen(true),
          ]),
        ));
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
                    true,
                  );
                });
          }),
    );
  }
}
