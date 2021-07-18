import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({ Key key }) : super(key: key);

  static const routeName = '/screen-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}