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
    final _feedData = Provider.of<FeedProvider>(context).feedItems;
    final _isAdmin = Provider.of<UserProvider>(context, listen: false).getIsAdminStatus;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 1.17,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
          child: FeedCard(),
          value: _feedData[index],
        ),
        itemCount: _feedData.length,
      ),
      floatingActionButton: _isAdmin ? FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(NewFeedForm.routeName);
        },
        child: Icon(Icons.add),
      ) : null,
    );
  }
}
