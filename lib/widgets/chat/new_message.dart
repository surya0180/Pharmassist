import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmassist/providers/user.dart';
import 'package:provider/provider.dart';

class NewMessage extends StatefulWidget {
  const NewMessage(this.userId, {Key key}) : super(key: key);

  final String userId;

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredMessage = '';

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    _controller.clear();
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    FirebaseFirestore.instance
        .collection('Chat')
        .doc(widget.userId)
        .collection('messages')
        .add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData.data()['fullName'],
    });
    var _isAdmin =
        Provider.of<UserProvider>(context, listen: false).getIsAdminStatus;
    if (_isAdmin) {
      await FirebaseFirestore.instance
          .collection('Chat')
          .doc(widget.userId)
          .update({
        'timestamp': Timestamp.now(),
        'latestMessage': _enteredMessage,
      });
    } else {
      await FirebaseFirestore.instance
          .collection('Chat')
          .doc(widget.userId)
          .update({
        'name': user.displayName,
        'timestamp': Timestamp.now(),
        'latestMessage': _enteredMessage,
      });
    }
  }

  final _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 12),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.01,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                fillColor: Colors.grey[300],
                filled: true,
                labelText: 'Type a message',
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.03,
          ),
          CircleAvatar(
            backgroundColor: Theme.of(context).buttonColor,
            child: IconButton(
              onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
              icon: Icon(
                Icons.send,
                color: Colors.white,
              ),
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
