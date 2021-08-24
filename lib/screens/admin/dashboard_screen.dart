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
          appBar: AppBar(
            title: const Text("Dashboard"),
            backgroundColor: Colors.lightGreenAccent[100],
            bottom: TabBar(
              indicatorColor: Colors.red,
              tabs: [
                const Tab(
                  // icon: Icon(Icons.account_circle),
                  text: "Pharmassists",
                ),
                const Tab(
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
