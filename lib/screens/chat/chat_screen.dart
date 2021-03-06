import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmassist/widgets/chat/messages.dart';
import 'package:pharmassist/widgets/chat/new_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key key}) : super(key: key);

  static const routeName = '/chat-screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String userName;
  String userId;
  String uidX;
  int _unreadMsg;
  bool _isSent;
  String _timestamp;

  void setIsSent(bool status) {
    setState(() {
      _isSent = status;
    });
  }

  void setTimestamp(String timestamp) {
    setState(() {
      _timestamp = timestamp;
    });
  }

  @override
  void didChangeDependencies() {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    userName = routeArgs['name'];
    userId = routeArgs['userId'];
    uidX = routeArgs['uidX'];
    if (userId == FirebaseAuth.instance.currentUser.uid) {
      FirebaseFirestore.instance
          .collection('Chat')
          .doc(userId)
          .get()
          .then((value) {
        setState(() {
          _unreadMsg = value.data()['hostB'];
        });
      });
    } else {
      FirebaseFirestore.instance
          .collection('Chat')
          .doc(userId)
          .get()
          .then((value) {
        setState(() {
          _unreadMsg = value.data()['hostA'];
        });
      });
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (userId == FirebaseAuth.instance.currentUser.uid) {
      FirebaseFirestore.instance
          .collection('Chat')
          .doc(userId)
          .update({'hostB': 0});
    } else {
      FirebaseFirestore.instance
          .collection('Chat')
          .doc(userId)
          .update({'hostA': 0});
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          userName,
          style: Theme.of(context).textTheme.title,
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(userId, _unreadMsg, _isSent, _timestamp),
            ),
            NewMessage(userId, uidX, setIsSent, setTimestamp),
          ],
        ),
      ),
    );
  }
}
