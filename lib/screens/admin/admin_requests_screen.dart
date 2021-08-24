import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmassist/providers/auth/admin-provider.dart';
import 'package:pharmassist/widgets/requests/request_item.dart';
import 'package:provider/provider.dart';

import 'medic_req_screen.dart';
import 'pharm_req_screen.dart';

class AdminRequestScreen extends StatefulWidget {
  static const routeName = '/admin-request-screen';
  @override
  _AdminRequestScreenState createState() => _AdminRequestScreenState();
}

class _AdminRequestScreenState extends State<AdminRequestScreen> {
  int _value = 1;
  // ignore: non_constant_identifier_names
  String RequestType = "pharm";
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AdminProvider>(context, listen: false).updateRequests(0);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: AppBar(
              foregroundColor: Colors.green,
              backgroundColor: Colors.blue[200],
              bottom: TabBar(
                indicatorColor: Colors.red,
                tabs: [
                   const Tab(
                    text: "Pharmassists",
                  ),
                   const Tab(
                    text: "Medicals",
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(children: [
            PharmReqScreen(false),
            MedicReqScreen(false),
          ]),
        ));
  }
}
