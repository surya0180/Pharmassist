import 'package:flutter/material.dart';
import 'package:pharmassist/widgets/FeedCard.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return FeedCard();
      },
      itemCount: 5,
    );
  }
}
