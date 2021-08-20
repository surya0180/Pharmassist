import 'package:flutter/material.dart';

class NoResultsFound extends StatelessWidget {
  const NoResultsFound({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context).size;
    return Center(
      child: ListView(
        children: [
          SizedBox(
            height: device.height*0.26,
          ),
          const Icon(
            Icons.no_accounts,
            size: 70,
          ),
          SizedBox(height: device.height*0.02,),
          const Center(
            child: const  Text(
              'No results found',
              style:const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
