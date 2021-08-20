import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmassist/providers/NetworkNotifier.dart';
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
      margin: const EdgeInsets.only(left: 10, right: 10),
      decoration: const BoxDecoration(
        border: Border(
          bottom: const BorderSide(width: 1.0, color: Colors.black26),
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
                          width: device.width * 0.05,
                        ),
                        Flexible(
                          child: Text(
                            widget.title,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_isAdmin)
                    DropdownButton(
                      icon: const Icon(Icons.more_vert),
                      underline: Container(),
                      items: const [
                        DropdownMenuItem(
                          value: 'delete',
                          child: const Text(
                            'Delete feed',
                            style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 12,
                            ),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'edit',
                          child: const Text(
                            'Edit feed',
                            style: const TextStyle(
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
                              title: const Text('Are you sure?'),
                              content: const Text(
                                'Do you want to delete this feed ?',
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: const Text('No'),
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                ),
                                FlatButton(
                                  child: const Text('Yes'),
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                    Provider.of<NetworkNotifier>(context,
                                            listen: false)
                                        .setIsConnected()
                                        .then((value) {
                                      if (Provider.of<NetworkNotifier>(context,
                                              listen: false)
                                          .getIsConnected) {
                                        Provider.of<FeedProvider>(context,
                                                listen: false)
                                            .deleteFeed(widget.id)
                                            .then((value) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              margin: const EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                  bottom: 40),
                                              duration: const Duration(seconds: 2),
                                              content: const Text(
                                                'Deleted feed sucessfully',
                                              ),
                                            ),
                                          );
                                        });
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.red,
                                            content: const Text(
                                              'Please check your network connection',
                                            ),
                                            duration: const Duration(
                                                seconds: 1, milliseconds: 200),
                                          ),
                                        );
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          );
                        } else {
                          Provider.of<NetworkNotifier>(context, listen: false)
                              .setIsConnected()
                              .then((value) {
                            if (Provider.of<NetworkNotifier>(context,
                                    listen: false)
                                .getIsConnected) {
                              Navigator.of(context)
                                  .pushNamed(NewFeedForm.routeName, arguments: {
                                'id': widget.id,
                                'title': widget.title,
                                'content': widget.content,
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red,
                                  content: const Text(
                                    'Please check your network connection',
                                  ),
                                  duration:
                                      const Duration(seconds: 1, milliseconds: 200),
                                ),
                              );
                            }
                          });
                        }
                      },
                    ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: device.width * 0.19,
                  ),
                  Flexible(
                    child: Text(
                      widget.content.length > 28
                          ? widget.content.substring(0, 28) + '. . . .'
                          : widget.content,
                      style: const TextStyle(color: Colors.black54),
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
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: device.width * 0.03,
                      ),
                      Text(
                        '${widget.createdOn}',
                        style: const TextStyle(
                            color: Colors.black38, fontSize: 10),
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
                          Provider.of<NetworkNotifier>(context, listen: false)
                              .setIsConnected()
                              .then((value) {
                            if (Provider.of<NetworkNotifier>(context,
                                    listen: false)
                                .getIsConnected) {
                              if (!_isAdded) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                        'Please complete your profile'),
                                    duration: const Duration(
                                        seconds: 1, milliseconds: 200),
                                  ),
                                );
                              } else {
                                feed.addToLikedUsers(!_isLiked, widget.id,
                                    widget.likes, widget.likedUsers);
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red,
                                  content: const Text(
                                    'Please check your network connection',
                                  ),
                                  duration: const Duration(
                                      seconds: 1, milliseconds: 200),
                                ),
                              );
                            }
                          });
                        },
                        color: Theme.of(context).accentColor,
                      ),
                      Text(
                        '${widget.likes}',
                        style: const TextStyle(
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
