import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pharmassist/providers/NetworkNotifier.dart';
import 'package:pharmassist/providers/auth/user.dart';
import 'package:provider/provider.dart';

class ImpNewMessage extends StatefulWidget {
  const ImpNewMessage(
    this.userId,
    this.bucketId,
    this.participants,
    this.unreadMessages,
    this.setisSent,
    this.setTimestamp, {
    Key key,
  }) : super(key: key);

  final String userId;
  final String bucketId;
  final List participants;
  final int unreadMessages;
  final Function setisSent;
  final Function setTimestamp;

  @override
  _ImpNewMessageState createState() => _ImpNewMessageState();
}

class _ImpNewMessageState extends State<ImpNewMessage> {
  var _enteredMessage = '';

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    _controller.clear();
    widget.setisSent(false);
    final hmstamp = DateTime.now();
    final timestamp = Timestamp.now();
    final user = FirebaseAuth.instance.currentUser;
    widget.setTimestamp(hmstamp.toIso8601String());
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    final token = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .get();
    final chatData = await FirebaseFirestore.instance
        .collection('chat')
        .doc(widget.userId)
        .collection('chatList')
        .doc(user.uid)
        .get();
    FirebaseFirestore.instance
        .collection('chatMessages')
        .doc(widget.bucketId)
        .collection('messages')
        .add({
      'text': _enteredMessage.trim(),
      'createdAt': timestamp,
      'timestamp': DateFormat.Hm().format(hmstamp),
      'userId': user.uid,
      'username': userData.data()['fullName'],
      'sentAt': hmstamp.toIso8601String(),
      'notificationArgs': [
        widget.userId,
        widget.bucketId,
        widget.participants[0],
        widget.participants[1],
        widget.unreadMessages
      ],
      'token': token.data()['deviceToken']
    }).then((value) async {
      if (widget.participants[0] == user.uid) {
        print("I am in the if case");
        await FirebaseFirestore.instance
            .collection('chat')
            .doc(widget.participants[1])
            .collection('chatList')
            .doc(widget.participants[0])
            .update({
          'timestamp': timestamp,
          'latestMessage': _enteredMessage.trim(),
          'username': userData.data()['fullName'],
          'profilePic': userData.data()['PhotoUrl'],
          'unreadMessages': chatData.data()['unreadMessages'] + 1,
        });
        await FirebaseFirestore.instance
            .collection('chat')
            .doc(widget.participants[0])
            .collection('chatList')
            .doc(widget.participants[1])
            .update({
          'timestamp': timestamp,
          'latestMessage': _enteredMessage.trim(),
        });
      } else {
        print("I am in the else case");
        await FirebaseFirestore.instance
            .collection('chat')
            .doc(widget.participants[0])
            .collection('chatList')
            .doc(widget.participants[1])
            .update({
          'timestamp': timestamp,
          'latestMessage': _enteredMessage.trim(),
          'username': userData.data()['fullName'],
          'profilePic': userData.data()['PhotoUrl'],
          'unreadMessages': chatData.data()['unreadMessages'] + 1,
        });
        await FirebaseFirestore.instance
            .collection('chat')
            .doc(widget.participants[1])
            .collection('chatList')
            .doc(widget.participants[0])
            .update({
          'timestamp': timestamp,
          'latestMessage': _enteredMessage.trim(),
        });
      }
      widget.setisSent(true);
    });
  }

  final _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 12),
      padding: const EdgeInsets.all(8),
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
                contentPadding: const EdgeInsets.all(10),
                fillColor: Colors.grey[300],
                filled: true,
                labelText: 'Type a message',
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: const OutlineInputBorder(
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
                    _enteredMessage.trim().isEmpty ? print("") : _sendMessage();
                  } else {
                    Navigator.of(context).pop(true);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: const Text(
                          'Please check your network connection',
                        ),
                        duration: const Duration(seconds: 1, milliseconds: 200),
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
