import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmassist/providers/NetworkNotifier.dart';
import 'package:pharmassist/providers/feed/feed_provider.dart';
import 'package:pharmassist/providers/auth/user.dart';
import 'package:provider/provider.dart';

class FeedLikes extends StatefulWidget {
  const FeedLikes(this.id, this.likes, this.likedUsers, {Key key})
      : super(key: key);

  final String id;
  final int likes;
  final dynamic likedUsers;

  @override
  _FeedLikesState createState() => _FeedLikesState();
}

class _FeedLikesState extends State<FeedLikes> {
  var _isLiked;
  var _likes;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    final uid = FirebaseAuth.instance.currentUser.uid;
    if (widget.likedUsers['$uid'] == null) {
      setState(() {
        _isLiked = false;
        _likes = widget.likes;
      });
    } else {
      setState(() {
        _isLiked = widget.likedUsers['$uid']['isLiked'];
        _likes = widget.likes;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _isAdded =
        Provider.of<UserProvider>(context, listen: false).getIsAddedStatus;
    return Row(
      children: [
        IconButton(
          icon: Icon(
            _isLiked == null
                ? Icons.thumb_up_alt_outlined
                : _isLiked
                    ? Icons.thumb_up
                    : Icons.thumb_up_alt_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            Provider.of<NetworkNotifier>(context, listen: false)
                .setIsConnected()
                .then((value) {
              if (Provider.of<NetworkNotifier>(context, listen: false)
                  .getIsConnected) {
                if (!_isAdded) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.black,
                      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 40),
                      duration: const Duration(seconds: 2),
                      content:const Text('Please complete your profile'),
                    ),
                  );
                } else {
                  Provider.of<FeedProvider>(
                    context,
                    listen: false,
                  ).addToLikedUsers(
                    !_isLiked,
                    widget.id,
                    _likes,
                    widget.likedUsers,
                  );
                  if (_isLiked) {
                    setState(() {
                      _likes = _likes - 1;
                    });
                  } else {
                    setState(() {
                      _likes = _likes + 1;
                    });
                  }
                  setState(() {
                    _isLiked = !_isLiked;
                  });
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: const Text(
                      'Please check your network connection',
                    ),
                    duration:const Duration(seconds: 1, milliseconds: 200),
                  ),
                );
              }
            });
          },
          color: Theme.of(context).accentColor,
        ),
        Text(
          '$_likes',
          style:const TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
