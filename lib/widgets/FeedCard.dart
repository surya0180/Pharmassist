import 'package:flutter/material.dart';

class FeedCard extends StatelessWidget {
  const FeedCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      margin: EdgeInsets.all(20),
      child: InkWell(
        onTap: () {},
        splashColor: Colors.greenAccent,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          height: 260,
        ),
      ),
    );
  }
}
