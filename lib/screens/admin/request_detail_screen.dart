import 'package:flutter/material.dart';

class RequestDetailScreen extends StatelessWidget {
  static const routeName = "/rquest-detail-screen";
  String userName;
  String photoUrl;
  String title;
  String detail;
  String createdOn;
  String uid;

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
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Don't show the leading button
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back, color: Colors.black),
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(photoUrl),
              radius: 15,
            ),
            SizedBox(
              width: 5,
            ),
            Text(userName)
            // Your widgets here
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              // logic to chat
            },
            icon: Icon(Icons.chat),
            iconSize: 30,
          ),
          SizedBox(
            width: 30,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                child: Column(
                  children: [
                    Padding(
                        padding:
                            EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                        child: new Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            new Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                new Text(
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
                        padding:
                            EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
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
                child: Column(
                  children: [
                    Padding(
                        padding:
                            EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                        child: new Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            new Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                new Text(
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
                        padding:
                            EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
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
