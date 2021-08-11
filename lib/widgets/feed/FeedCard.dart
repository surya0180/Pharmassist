import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmassist/providers/feed/feed_provider.dart';
import 'package:pharmassist/providers/auth/user.dart';
import 'package:pharmassist/screens/feeds/feed_detail_screeen.dart';
import 'package:provider/provider.dart';

import 'new_feed_form.dart';

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
    final device = MediaQuery.of(context).size;
    final feed = Provider.of<FeedProvider>(context, listen: false);
    final uid = FirebaseAuth.instance.currentUser.uid;
    var _isLiked;
    if (widget.likedUsers['$uid'] == null) {
      _isLiked = false;
    } else {
      _isLiked = widget.likedUsers['$uid']['isLiked'];
    }

    final _isAdmin =
        Provider.of<UserProvider>(context, listen: false).getIsAdminStatus;
    final _isAdded =
        Provider.of<UserProvider>(context, listen: false).getIsAddedStatus;

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(widget.profilePic),
                        ),
                        SizedBox(
                          width: device.width*0.05,
                        ),
                        Flexible(
                          child: Text(
                            widget.title,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_isAdmin)
                    DropdownButton(
                      icon: Icon(Icons.more_vert),
                      underline: Container(),
                      items: [
                        DropdownMenuItem(
                          value: 'delete',
                          child: Text(
                            'Delete feed',
                            style: TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 12,
                            ),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'edit',
                          child: Text(
                            'Edit feed',
                            style: TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 12,
                            ),
                          ),
                        )
                      ],
                      onChanged: (itemIdentifier) {
                        if (itemIdentifier == 'delete') {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Text('Are you sure?'),
                              content: Text(
                                'Do you want to delete this feed ?',
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('No'),
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                ),
                                FlatButton(
                                  child: Text('Yes'),
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                    Provider.of<FeedProvider>(context,
                                            listen: false)
                                        .deleteFeed(widget.id)
                                        .then((value) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Deleted feed sucessfully',
                                          ),
                                        ),
                                      );
                                    });
                                  },
                                ),
                              ],
                            ),
                          );
                        } else {
                          Navigator.of(context)
                              .pushNamed(NewFeedForm.routeName, arguments: {
                            'id': widget.id,
                            'title': widget.title,
                            'content': widget.content,
                          });
                        }
                      },
                    ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: device.width*0.19,
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
                        width: device.width*0.03,
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
                          if (!_isAdded) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please complete your profile'),
                                duration:
                                    Duration(seconds: 1, milliseconds: 200),
                              ),
                            );
                          } else {
                            feed.addToLikedUsers(!_isLiked, widget.id,
                                widget.likes, widget.likedUsers);
                          }
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