import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmassist/providers/feed_provider.dart';
import 'package:pharmassist/providers/user.dart';
import 'package:pharmassist/screens/comments_screen.dart';
import 'package:pharmassist/screens/feed_detail_screeen.dart';
import 'package:pharmassist/widgets/new_feed_form.dart';
import 'package:provider/provider.dart';

class FeedCard extends StatefulWidget {
  const FeedCard(
      {this.id,
      this.title,
      this.content,
      this.color,
      this.likes,
      this.createdOn,
      this.updatedOn,
      this.likedUsers,
      Key key})
      : super(key: key);

  final String id;
  final String title;
  final String content;
  final int likes;
  final Color color;
  final Timestamp createdOn;
  final Timestamp updatedOn;
  final Map<String, dynamic> likedUsers;

  @override
  _FeedCardState createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {
  @override
  Widget build(BuildContext context) {
    final feed = Provider.of<FeedProvider>(context, listen: false);
    var device = MediaQuery.of(context).size;
    final _isAdmin =
        Provider.of<UserProvider>(context, listen: false).getIsAdminStatus;
    final uid = FirebaseAuth.instance.currentUser.uid;
    var _isLiked;
    if (widget.likedUsers['$uid'] == null) {
      _isLiked = false;
    } else {
      _isLiked = widget.likedUsers['$uid']['isLiked'];
    }

    return Card(
      color: widget.color,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(device.height * 0.02)),
      elevation: 4,
      margin: EdgeInsets.all(device.height * 0.027),
      child: GridTile(
        header: Container(
          alignment: Alignment(0, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(device.height * 0.02),
              topRight: Radius.circular(device.height * 0.02),
            ),
            color: Colors.black26,
          ),
          height: device.height * 0.059,
          child: Text(
            widget.title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          margin: EdgeInsets.only(top: device.height * 0.0001),
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              FeedDetailScreen.routeName,
              arguments: {
                'title': widget.title,
                'content': widget.content,
                'color': widget.color,
                'createdOn': widget.createdOn,
                'updatedOn': widget.updatedOn,
              },
            );
          },
          splashColor: Theme.of(context).splashColor,
          borderRadius: BorderRadius.circular(device.height * 0.02),
          child: Container(
            decoration: BoxDecoration(boxShadow: []),
            child: Padding(
              padding: EdgeInsets.only(
                  left: device.height * 0.027,
                  right: device.height * 0.027,
                  top: device.height * 0.0828,
                  bottom: device.height * 0.018),
              child: Text(widget.content),
            ),
          ),
        ),
        footer: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              blurRadius: device.height * 0.03,
              offset: Offset(0, -15),
              spreadRadius: 1,
              color: Colors.grey[200],
            )
          ]),
          child: GridTileBar(
            leading: IconButton(
              icon: Icon(
                _isLiked == null
                    ? Icons.thumb_up_alt_outlined
                    : _isLiked
                        ? Icons.thumb_up
                        : Icons.thumb_up_alt_outlined,
                color: widget.color,
              ),
              onPressed: () {
                feed.addToLikedUsers(
                    !_isLiked, widget.id, widget.likes, widget.likedUsers);
              },
              color: Theme.of(context).accentColor,
            ),
            backgroundColor: Colors.black87,
            title: Align(
              child: Text(
                '${widget.likes}',
                textAlign: TextAlign.center,
              ),
              alignment: Alignment(-1.1, 0),
            ),
            trailing: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.comment,
                    color: widget.color,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(CommentScreen.routeName,
                        arguments: widget.id);
                  },
                  color: Theme.of(context).accentColor,
                ),
                if (_isAdmin)
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: widget.color,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(NewFeedForm.routeName, arguments: {
                        'id': widget.id,
                        'title': widget.title,
                        'content': widget.content,
                      });
                    },
                    color: Theme.of(context).accentColor,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
