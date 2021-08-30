import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmassist/providers/notification-provider.dart';
import 'package:pharmassist/widgets/chat/imp_messages.dart';
import 'package:pharmassist/widgets/chat/imp_new_message.dart';
import 'package:pharmassist/widgets/chat/messages.dart';
import 'package:pharmassist/widgets/chat/new_message.dart';
import 'package:provider/provider.dart';

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
  String bucketId;
  int unreadMessages;
  bool _isSent;
  String _timestamp;
  List participants;

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
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    userName = routeArgs['username'];
    userId = routeArgs['uid'];
    bucketId = routeArgs['bucketId'];
    participants = routeArgs['participants'];
    unreadMessages = routeArgs['unreadMessages'];
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<NotificationProvider>(context, listen: false)
          .setTotalUnreadMessages(unreadMessages);
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (participants[0] == FirebaseAuth.instance.currentUser.uid) {
      print("I am in if chatscreen");
      FirebaseFirestore.instance
          .collection('chat')
          .doc(participants[0])
          .collection('chatList')
          .doc(participants[1])
          .update({'unreadMessages': 0});
    } else {
      print("I am in else chatscreen");
      FirebaseFirestore.instance
          .collection('chat')
          .doc(participants[1])
          .collection('chatList')
          .doc(participants[0])
          .update({'unreadMessages': 0});
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
              child: ImpMessages(
                userId,
                bucketId,
                unreadMessages,
                _isSent,
                _timestamp,
              ),
            ),
            ImpNewMessage(
              userId,
              bucketId,
              participants,
              setIsSent,
              setTimestamp,
            ),
          ],
        ),
      ),
    );
  }
}
