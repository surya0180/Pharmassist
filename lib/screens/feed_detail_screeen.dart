import 'package:flutter/material.dart';
import 'package:pharmassist/widgets/FeedStamp.dart';

class FeedDetailScreen extends StatefulWidget {
  const FeedDetailScreen({Key key}) : super(key: key);

  static const routeName = '/feed-details';

  @override
  _FeedDetailScreenState createState() => _FeedDetailScreenState();
}

class _FeedDetailScreenState extends State<FeedDetailScreen> {
  String title, content;
  Color color;

  @override
  void didChangeDependencies() {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    title = routeArgs['title'];
    content = routeArgs['content'];
    color = routeArgs['color'];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: color,
        title: Text(
          title,
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
              title: title,
              color: color,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(7),
              ),
              color: color,
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
              color: color,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(content),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
