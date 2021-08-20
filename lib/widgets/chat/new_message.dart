import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pharmassist/providers/NetworkNotifier.dart';
import 'package:pharmassist/providers/auth/user.dart';
import 'package:provider/provider.dart';

class NewMessage extends StatefulWidget {
  const NewMessage(this.userId, this.uidX, this.setIsSent, this.setTimestamp,
      {Key key})
      : super(key: key);

  final String userId;
  final String uidX;
  final Function setIsSent;
  final Function setTimestamp;

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredMessage = '';

  void _sendMessage() async {
    widget.setIsSent(false);
    FocusScope.of(context).unfocus();
    _controller.clear();
    final hmstamp = DateTime.now();
    final timestamp = Timestamp.now();
    final user = FirebaseAuth.instance.currentUser;
    widget.setTimestamp(hmstamp.toIso8601String());
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    final realUserData = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .get();
    final chatData = await FirebaseFirestore.instance
        .collection('Chat')
        .doc(widget.userId)
        .get();
    final adminData = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uidX)
        .get();
    var _isAdmin =
        Provider.of<UserProvider>(context, listen: false).getIsAdminStatus;
    FirebaseFirestore.instance
        .collection('Chat')
        .doc(widget.userId)
        .collection('messages')
        .add({
      'text': _enteredMessage.trim(),
      'createdAt': timestamp,
      'timestamp': DateFormat.Hm().format(hmstamp),
      'userId': user.uid,
      'username': userData.data()['fullName'],
      'sentAt': hmstamp.toIso8601String(),
      'notificationArgs': [widget.userId, widget.uidX],
      'token': _isAdmin
          ? realUserData.data()['deviceToken']
          : adminData.data()['deviceToken'],
    });
    if (_isAdmin) {
      await FirebaseFirestore.instance
          .collection('Chat')
          .doc(widget.userId)
          .update({
        'timestamp': timestamp,
        'latestMessage': _enteredMessage.trim(),
        'name': realUserData.data()['fullName'],
        'profilePic': realUserData.data()['PhotoUrl'],
        'hostB': chatData.data()['hostB'] + 1,
      }).then((value) {
        widget.setIsSent(true);
      });
    } else {
      await FirebaseFirestore.instance
          .collection('Chat')
          .doc(widget.userId)
          .update({
        'name': userData.data()['fullName'],
        'profilePic': userData.data()['PhotoUrl'],
        'timestamp': timestamp,
        'latestMessage': _enteredMessage.trim(),
        'hostA': chatData.data()['hostA'] + 1,
      }).then((value) {
        widget.setIsSent(true);
      });
    }
  }

  final _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.only(top: 8, bottom: 12),
      padding:const EdgeInsets.all(8),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.01,
          ),
          Expanded(
            child: TextField(
              maxLines: 2,
              controller: _controller,
              decoration: InputDecoration(
                contentPadding:const EdgeInsets.all(10),
                fillColor: Colors.grey[300],
                filled: true,
                labelText: 'Type a message',
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border:const OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
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
              onPressed: () {
                Provider.of<NetworkNotifier>(context, listen: false)
                    .setIsConnected()
                    .then((value) {
                  if (Provider.of<NetworkNotifier>(context, listen: false)
                      .getIsConnected) {
                    _enteredMessage.trim().isEmpty
                        ? print("Hello")
                        : _sendMessage();
                  } else {
                    Navigator.of(context).pop(true);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
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
              icon: const Icon(
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
