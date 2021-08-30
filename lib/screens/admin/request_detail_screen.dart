import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmassist/providers/NetworkNotifier.dart';
import 'package:pharmassist/screens/chat/chat_screen.dart';
import 'package:pharmassist/screens/tabs/profile_screen.dart';
import 'package:provider/provider.dart';
import '../../helpers/string_extension.dart';

class RequestDetailScreen extends StatefulWidget {
  static const routeName = "/rquest-detail-screen";

  @override
  _RequestDetailScreenState createState() => _RequestDetailScreenState();
}

class _RequestDetailScreenState extends State<RequestDetailScreen> {
  String userName;
  String photoUrl;
  String title;
  String detail;
  String createdOn;
  String uid;
  Map<String, dynamic> chatData;

  var _isLoading;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _isLoading = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    if (routeArgs != null) {
      userName = routeArgs['userName'];
      photoUrl = routeArgs['photoUrl'];
      title = routeArgs['title'];
      detail = routeArgs['detail'];
      createdOn = routeArgs['createdOn'];
      uid = routeArgs['uid'];
      chatData = routeArgs['chatData'];
      print(userName);
      print(chatData);
    }
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 7,
            ),
            Text(userName)
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<NetworkNotifier>(context, listen: false)
                  .setIsConnected()
                  .then((value) {
                if (Provider.of<NetworkNotifier>(context, listen: false)
                    .getIsConnected) {
                  setState(() {
                    _isLoading = true;
                  });
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(uid)
                      .get()
                      .then((value) {
                    setState(() {
                      _isLoading = false;
                    });
                    Navigator.of(context)
                        .pushNamed(ProfilePage.routeName, arguments: {
                      'isSearchResult': true,
                      'profilePic': value.data()['PhotoUrl'],
                      'fullname': value.data()['fullName'],
                      'registerationNumber': value.data()['registrationNo'],
                      'renewalDate': value.data()['renewalDate'],
                      'street': value.data()['street'],
                      'town': value.data()['town'],
                      'district': value.data()['district'],
                      'state': value.data()['state'],
                      'uid': value.data()['uid'],
                    });
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: const Text(
                        'Please check your network connection',
                      ),
                      duration: Duration(seconds: 1, milliseconds: 200),
                    ),
                  );
                }
              });
            },
            icon: const Icon(Icons.account_box_rounded),
            iconSize: 24,
          ),
          IconButton(
            onPressed: () {
              print("I am here");
              Navigator.of(context).pushNamed(
                ChatScreen.routeName,
                arguments: {
                  'username': chatData['username'].toString().capitalize(),
                  'uid': chatData['uid'],
                  'bucketId': chatData['bucketId'],
                  'participants': chatData['participants'],
                  'unreadMessages': chatData['unreadMessages'],
                },
              );
            },
            icon: const Icon(Icons.chat),
            iconSize: 23,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: const CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Card(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      const Text(
                                        'About',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextFormField(
                                      initialValue: title,
                                      enabled: false,
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      const Text(
                                        'Request',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextFormField(
                                      minLines: 3,
                                      maxLines: 100,
                                      initialValue: detail,
                                      enabled: false,
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
