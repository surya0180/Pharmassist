import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmassist/providers/comment.dart';
import 'package:pharmassist/providers/comment_provider.dart';
import 'package:pharmassist/providers/user.dart';
import 'package:pharmassist/widgets/CommentHolder.dart';
import 'package:provider/provider.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({Key key}) : super(key: key);

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
    final _feedId = ModalRoute.of(context).settings.arguments as String;
    final _commentsData = Provider.of<CommentProvider>(context);
    final _username =
        Provider.of<UserProvider>(context, listen: false).user.fullname;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Comments',
          style: Theme.of(context).textTheme.title,
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
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
                maxLines: 2,
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
                  setState(() {
                    _comment = _controller.text;
                  });
                  _commentsData.addComment(
                    _feedId,
                    DateTime.now().toIso8601String(),
                    _comment,
                    _username,
                  );
                  _controller.clear();
                  FocusScope.of(context).unfocus();
                },
                icon: Icon(
                  Icons.send,
                  color: Colors.black,
                ),
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('commentSections/')
                  .doc(_feedId)
                  .collection('comments/')
                  .orderBy('id', descending: true)
                  .snapshots(),
              builder: (ctx, commentSnapShot) {
                if (commentSnapShot.connectionState ==
                    ConnectionState.waiting) {
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
                        padding: EdgeInsets.all(0),
                        itemBuilder: (ctx, index) {
                          return CommentHolder(
                            id: commentDocs[index].data()['id'],
                            username: commentDocs[index].data()['username'],
                            comment: commentDocs[index].data()['comment'],
                          );
                        },
                        itemCount: commentDocs.length,
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
