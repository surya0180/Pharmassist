import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pharmassist/helpers/Colors.dart';
import 'package:pharmassist/widgets/FeedCard.dart';
import 'package:pharmassist/widgets/new_feed_form.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key key}) : super(key: key);

  static const routeName = '/feed-screen';

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  Color _generateRandomColor() {
    var rc = Random();
    return themeColors[rc.nextInt(10)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 1.17,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, index) {
          return FeedCard(randomColor: _generateRandomColor(),);
        },
        itemCount: 5,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(NewFeedForm.routeName);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
