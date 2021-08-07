import 'package:flutter/material.dart';

class NoResultsFound extends StatelessWidget {
  const NoResultsFound({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
        ),
        Icon(
          Icons.no_accounts,
          size: 70,
        ),
        SizedBox(height: 10,),
        Text(
          'No results found',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
