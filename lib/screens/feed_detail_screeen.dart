import 'package:flutter/material.dart';
import 'package:pharmassist/screens/comments_screen.dart';
import 'package:pharmassist/widgets/FeedDetailedLikes.dart';

class FeedDetailScreen extends StatelessWidget {
  const FeedDetailScreen({Key key}) : super(key: key);

  static const routeName = '/feed-details';

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context).size;
    final _feedData =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              _feedData['title'],
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ),
                          FeedLikes(
                            _feedData['id'],
                            _feedData['likes'],
                            _feedData['likedUsers'],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: device.height*0.031,
                      ),
                      Text(_feedData['content']),
                      SizedBox(
                        height: device.height*0.031,
                      ),
                      CommentScreen(_feedData['id']),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
