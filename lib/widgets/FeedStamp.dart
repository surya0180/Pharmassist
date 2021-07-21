import 'package:flutter/material.dart';

class FeedStamp extends StatelessWidget {
  const FeedStamp({this.title, this.color, Key key}) : super(key: key);

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
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
                Text('06/07/2021 19:15'),
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
                Text('07/07/2021 19:15'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
