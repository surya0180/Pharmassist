import 'package:flutter/material.dart';

class CommentHolder extends StatelessWidget {
  const CommentHolder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.black26),
        ),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Henry',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  width: 200,
                ),
                Text(
                  '5ds ago',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                      color: Colors.black26),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Text('This is my comment This is my comment This is my comment'),
          ],
        ),
      ),
    );
  }
}
