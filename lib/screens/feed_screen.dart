import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pharmassist/widgets/FeedCard.dart';
import 'package:pharmassist/widgets/new_feed_form.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key key}) : super(key: key);

  static const routeName = '/feed-screen';

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return FeedCard();
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
