import 'package:flutter/material.dart';

class StartSearching extends StatelessWidget {
  const StartSearching({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
        ),
        Icon(
          Icons.search,
          size: 70,
        ),
        Text(
          'Start searching',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
