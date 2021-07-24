import 'package:flutter/material.dart';
import 'package:pharmassist/providers/comment.dart';
import 'package:provider/provider.dart';

class CommentHolder extends StatelessWidget {
  const CommentHolder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final comment = Provider.of<Comment>(context, listen: false);

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  comment.username,
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                Text(
                  '5ds ago',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                    color: Colors.black26,
                  ),
                ),
              ],
            ),
            Text(comment.comment),
          ],
        ),
      ),
    );
  }
}
