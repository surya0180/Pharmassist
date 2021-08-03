import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmassist/providers/feed_provider.dart';
import 'package:pharmassist/providers/user.dart';
import 'package:pharmassist/screens/feed_detail_screeen.dart';
import 'package:provider/provider.dart';

class FeedCard extends StatefulWidget {
  const FeedCard(
      {this.id,
      this.title,
      this.content,
      this.color,
      this.likes,
      this.createdOn,
      this.likedUsers,
      this.createdBy,
      this.profilePic,
      Key key})
      : super(key: key);

  final String id;
  final String title;
  final String content;
  final int likes;
  final Color color;
  final String createdOn;
  final String createdBy;
  final String profilePic;
  final Map<String, dynamic> likedUsers;

  @override
  _FeedCardState createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {
  @override
  Widget build(BuildContext context) {
    final feed = Provider.of<FeedProvider>(context, listen: false);
    final uid = FirebaseAuth.instance.currentUser.uid;
    var _isLiked;
    if (widget.likedUsers['$uid'] == null) {
      _isLiked = false;
    } else {
      _isLiked = widget.likedUsers['$uid']['isLiked'];
    }

    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.black26),
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            FeedDetailScreen.routeName,
            arguments: {
              'id': widget.id,
              'title': widget.title,
              'content': widget.content,
              'likes': widget.likes,
              'likedUsers': widget.likedUsers,
            },
          );
        },
        splashColor: Theme.of(context).accentColor,
        child: Padding(
          padding: const EdgeInsets.only(left: 5, top: 15, bottom: 6, right: 5),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                        Provider.of<UserProvider>(context, listen: false)
                            .user
                            .photoUrl),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    child: Text(
                      widget.title,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 70,
                  ),
                  Flexible(
                    child: Text(
                      widget.content.length > 28
                          ? widget.content.substring(0, 28) + '. . . .'
                          : widget.content,
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        '${widget.createdBy}',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      Text(
                        '${widget.createdOn}',
                        style: TextStyle(color: Colors.black38, fontSize: 10),
                      ),
                    ],
                  ),
                  Row(
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
                          feed.addToLikedUsers(!_isLiked, widget.id,
                              widget.likes, widget.likedUsers);
                        },
                        color: Theme.of(context).accentColor,
                      ),
                      Text(
                        '${widget.likes}',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
