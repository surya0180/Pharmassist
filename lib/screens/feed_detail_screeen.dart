import 'package:flutter/material.dart';
import 'package:pharmassist/providers/feed_provider.dart';
import 'package:pharmassist/widgets/FeedStamp.dart';
import 'package:provider/provider.dart';

class FeedDetailScreen extends StatefulWidget {
  const FeedDetailScreen({Key key}) : super(key: key);

  static const routeName = '/feed-details';

  @override
  _FeedDetailScreenState createState() => _FeedDetailScreenState();
}

class _FeedDetailScreenState extends State<FeedDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final _feedId = ModalRoute.of(context).settings.arguments as String;
    final _feedData =
        Provider.of<FeedProvider>(context, listen: false).findById(_feedId);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: _feedData.color,
        title: Text(
          _feedData.title,
          style: Theme.of(context).textTheme.title,
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(15),
            height: 150,
            width: 350,
            child: FeedStamp(
              title: _feedData.title,
              color: _feedData.color,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(7),
              ),
              color: _feedData.color,
            ),
            padding: EdgeInsets.all(5),
            child: Text(
              'Feed Content',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: Card(
              color: _feedData.color,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(_feedData.content),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
