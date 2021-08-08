import 'package:flutter/material.dart';

class StartSearching extends StatelessWidget {
  const StartSearching({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: device.height*0.25,
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
