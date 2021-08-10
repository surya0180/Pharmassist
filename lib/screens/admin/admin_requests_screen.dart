import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmassist/providers/auth/admin-provider.dart';
import 'package:pharmassist/widgets/requests/request_item.dart';
import 'package:provider/provider.dart';

import 'medic_req_screen.dart';
import 'pharm_req_screen.dart';

class AdminRequestScreen extends StatefulWidget {
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

  final List<Map<String, Object>> _pages = [
    {'page': PharmReqScreen(), 'title': 'Pharmassists'},
    {'page': MedicReqScreen(), 'title': 'Medicals'},
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
      .where('isDeleted', isEqualTo: false)
      .snapshots();
  void setValue(value) {
    if (value == 0) {
      setState(() {
        RequestType = "pharm";
        streamBuilder = FirebaseFirestore.instance
            .collection('pharmacist requests')
            .orderBy('timestamp', descending: true)
            .where('isDeleted', isEqualTo: false)
            .snapshots();
      });
    } else {
      setState(() {
        RequestType = "medic";
        streamBuilder = FirebaseFirestore.instance
            .collection('medical requests')
            .orderBy('timestamp', descending: true)
            .where('isDeleted', isEqualTo: false)
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
            foregroundColor: Colors.green,
            backgroundColor: Colors.yellow,
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.account_circle),
                  text: "Pharmassists",
                ),
                Tab(
                  icon: Icon(Icons.store),
                  text: "Medicals",
                ),
              ],
            ),
          ),
          body: TabBarView(children: [
            PharmReqScreen(),
            MedicReqScreen(),
          ]),
        ));
  }
}

class Requsts extends StatelessWidget {
  const Requsts({
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


// appBar: AppBar(
      //   automaticallyImplyLeading: true,
      //   titleSpacing: 0.0,
      //   backgroundColor: Theme.of(context).canvasColor,
      //   elevation: 0,
      //   title: Container(
      //     padding: EdgeInsets.all(15.0),
      //     child: Container(
      //       padding: EdgeInsets.only(left: 5),
      //       color: Colors.cyan,
      //       child: DropdownButton(
      //           value: _value,
      //           items: [
      //             DropdownMenuItem(
      //               child: Text(
      //                 "pharmacist requests",
      //               ),
      //               value: 1,
      //             ),
      //             DropdownMenuItem(
      //               child: Text("medical requests"),
      //               value: 2,
      //             ),
      //           ],
      //           onChanged: (value) {
      //             setState(() {
      //               _value = value;
      //             });
      //             setValue(value);
      //           }),
      //     ),
      //   ),
      // ),
      // appBar: AppBar(
      //   title: Text(_pages[_selectedPageIndex]['title']),
      // ),
      // drawer: MainDrawer(),
      // body: _pages[_selectedPageIndex]['page'],
      // bottomNavigationBar: BottomNavigationBar(
      //   onTap: _selectPage,
      //   backgroundColor: Theme.of(context).primaryColor,
      //   unselectedItemColor: Colors.white,
      //   selectedItemColor: Theme.of(context).accentColor,
      //   currentIndex: _selectedPageIndex,
      //   type: BottomNavigationBarType.shifting,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.account_circle),
      //       title: Text('Pharmassists'),
      //     ),
      //     BottomNavigationBarItem(
      //       backgroundColor: Theme.of(context).primaryColor,
      //       icon: Icon(Icons.star),
      //       title: Text('Medicals'),
      //     )
      //   ],
      // ),
      // body: Requsts(
      //   streamBuilder: streamBuilder,
      //   requestType: RequestType,
      // ),