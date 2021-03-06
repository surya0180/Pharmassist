import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pharmassist/providers/NetworkNotifier.dart';
import 'package:pharmassist/providers/auth/user.dart';
import 'package:pharmassist/widgets/feed/FeedCard.dart';
import 'package:pharmassist/widgets/feed/new_feed_form.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key key}) : super(key: key);

  static const routeName = '/feed-screen';

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<NetworkNotifier>(context, listen: false).setIsConnected();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _isAdmin =
        Provider.of<UserProvider>(context, listen: false).getIsAdminStatus;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: RefreshIndicator(
        onRefresh:
            Provider.of<NetworkNotifier>(context, listen: false).setIsConnected,
        child: Provider.of<NetworkNotifier>(context, listen: false)
                .getIsConnected
            ? StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('feed/')
                    .where('isDeleted', isEqualTo: false)
                    .orderBy('id', descending: true)
                    .snapshots(),
                builder: (ctx, feedSnapShot) {
                  if (feedSnapShot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final feedDocs = feedSnapShot.data.docs;
                  return feedDocs.length == 0
                      ? _isAdmin
                          ? const Center(
                              child: Text('No feed posts yet! Create one?'),
                            )
                          : const Center(
                              child: Text('No feed posts published'),
                            )
                      : ListView.builder(
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
                              createdBy: feedDocs[index].data()['createdBy'],
                              profilePic: feedDocs[index].data()['profilePic'],
                            );
                          },
                        );
                },
              )
            : ListView(
                children: [
                  const SizedBox(
                    height: 320,
                  ),
                  const Center(
                    child: Text("Something went wrong!  Please try again"),
                  )
                ],
              ),
      ),
      floatingActionButton: _isAdmin
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed(NewFeedForm.routeName);
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
