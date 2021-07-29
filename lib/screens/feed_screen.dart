import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pharmassist/providers/feed_provider.dart';
import 'package:pharmassist/providers/user.dart';
import 'package:pharmassist/widgets/FeedCard.dart';
import 'package:pharmassist/widgets/new_feed_form.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key key}) : super(key: key);

  static const routeName = '/feed-screen';

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final _isAdmin =
        Provider.of<UserProvider>(context, listen: false).getIsAdminStatus;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('feed/')
            .orderBy('id', descending: true)
            .snapshots(),
        builder: (ctx, feedSnapShot) {
          if (feedSnapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final feedDocs = feedSnapShot.data.docs;
          // print(feedDocs[0].data()['likedUsers']['h9khKSLwKfXn2S9k35Z4DbBHgBj1']);
          return feedDocs.length == 0
              ? _isAdmin
                  ? Center(
                      child: Text('No feed posts yet! Create one?'),
                    )
                  : Center(
                      child: Text('No feed posts published'),
                    )
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 1.17,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: feedDocs.length,
                  itemBuilder: (ctx, index) {
                    String valueString = feedDocs[index]
                        .data()['color']
                        .split('(0x')[1]
                        .split(')')[0];
                    int value = int.parse(valueString, radix: 16);
                    Color otherColor = new Color(value);
                    return FeedCard(
                      id: feedDocs[index].data()['id'],
                      title: feedDocs[index].data()['title'],
                      content: feedDocs[index].data()['content'],
                      color: otherColor,
                      likedUsers: feedDocs[index].data()['likedUsers'],
                      likes: feedDocs[index].data()['likes'],
                      createdOn: feedDocs[index].data()['createdOn'],
                      updatedOn: feedDocs[index].data()['updatedOn'],
                    );
                  },
                );
        },
      ),
      floatingActionButton: _isAdmin
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed(NewFeedForm.routeName);
              },
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}
