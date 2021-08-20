import 'package:flutter/material.dart';

class CommentHolder extends StatelessWidget {
  const CommentHolder(
      {this.id, this.username, this.comment, this.createdAt, Key key})
      : super(key: key);

  final String id;
  final String username;
  final String comment;
  final String createdAt;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: const BorderSide(width: 1.0, color: Colors.black26),
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
                  username,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
                Text(
                  '$createdAt',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                    color: Colors.black26,
                  ),
                ),
              ],
            ),
            Text(
              comment,
            ),
          ],
        ),
      ),
    );
  }
}
