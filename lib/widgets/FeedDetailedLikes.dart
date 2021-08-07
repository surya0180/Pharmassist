import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmassist/providers/feed_provider.dart';
import 'package:pharmassist/providers/user.dart';
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
        print('i setted likes in if');
        _likes = widget.likes;
      });
    } else {
      setState(() {
        _isLiked = widget.likedUsers['$uid']['isLiked'];
        print('i setted likes in else');
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
            if (!_isAdded) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Please complete your profile'),
                  duration: Duration(seconds: 1, milliseconds: 200),
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
                  print('i setted likes in function if');
                  _likes = _likes - 1;
                });
              } else {
                setState(() {
                  print('i setted likes in function else');
                  _likes = _likes + 1;
                });
              }
              setState(() {
                _isLiked = !_isLiked;
              });
            }
          },
          color: Theme.of(context).accentColor,
        ),
        Text(
          '$_likes',
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
