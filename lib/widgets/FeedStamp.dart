import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FeedStamp extends StatelessWidget {
  const FeedStamp({this.title, this.color, this.createdOn, this.updatedOn, Key key}) : super(key: key);

  final String title;
  final Color color;
  final Timestamp createdOn;
  final Timestamp updatedOn;

  @override
  Widget build(BuildContext context) {
    var createdDate = DateTime.fromMillisecondsSinceEpoch(createdOn.millisecondsSinceEpoch);
    var updatedDate;
    if(updatedOn != null) {
      updatedDate = DateTime.fromMillisecondsSinceEpoch(updatedOn.millisecondsSinceEpoch);
    } else {
      updatedDate = 'No updates yet';
    }
    return Card(
      color: color,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "Title: ",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(title),
              ],
            ),
            Row(
              children: [
                Text(
                  "Author: ",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text('Admin'),
              ],
            ),
            Row(
              children: [
                Text(
                  "Created on: ",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text('$createdDate'),
              ],
            ),
            Row(
              children: [
                Text(
                  "Updated on: ",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text('$updatedDate'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
