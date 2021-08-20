import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pharmassist/helpers/HasNetwork.dart';
import 'package:pharmassist/providers/comments/comment_provider.dart';
import 'package:pharmassist/providers/auth/user.dart';
import 'package:pharmassist/widgets/feed/CommentHolder.dart';
import 'package:provider/provider.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen(this.feedId, {Key key}) : super(key: key);

  final String feedId;

  static const routeName = '/comments-screen';

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  var _comment = '';
  final _controller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _commentsData = Provider.of<CommentProvider>(context, listen: false);
    final _username =
        Provider.of<UserProvider>(context, listen: false).user.fullname;

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 1,
                color: Colors.black12,
                offset: Offset(2, 3),
                spreadRadius: 1,
              ),
            ],
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: ListTile(
            title: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Comment here',
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
              textInputAction: TextInputAction.done,
              onSubmitted: (value) {
                FocusScope.of(context).unfocus();
              },
            ),
            trailing: IconButton(
              onPressed: () {
                Provider.of<NetworkNotifier>(context, listen: false)
                    .setIsConnected()
                    .then((value) {
                  if (Provider.of<NetworkNotifier>(context, listen: false)
                      .getIsConnected) {
                    setState(() {
                      _comment = _controller.text;
                    });
                    var timestamp = DateTime.now();
                    _commentsData.addComment(
                      widget.feedId,
                      timestamp.toIso8601String(),
                      _comment,
                      _username,
                      DateFormat.yMd().format(timestamp),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Please check your network connection',
                        ),
                        duration: Duration(seconds: 1, milliseconds: 200),
                      ),
                    );
                  }
                });
                _controller.clear();
                FocusScope.of(context).unfocus();
              },
              icon: Align(
                alignment: Alignment(0, 1.8),
                child: Icon(
                  Icons.send,
                  color: Colors.black,
                ),
              ),
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('commentSections/')
              .doc(widget.feedId)
              .collection('comments/')
              .orderBy('id', descending: true)
              .snapshots(),
          builder: (ctx, commentSnapShot) {
            if (commentSnapShot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final commentDocs = commentSnapShot.data.docs;
            return commentDocs.length == 0
                ? Center(
                    child: Text('No comments so far!'),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(0),
                    itemBuilder: (ctx, index) {
                      return CommentHolder(
                        id: commentDocs[index].data()['id'],
                        username: commentDocs[index].data()['username'],
                        comment: commentDocs[index].data()['comment'],
                        createdAt: commentDocs[index].data()['createdAt'],
                      );
                    },
                    itemCount: commentDocs.length,
                  );
          },
        ),
      ],
    );
  }
}
