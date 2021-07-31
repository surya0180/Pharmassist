import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './message_bubble.dart';

class Messages extends StatefulWidget {
  const Messages(this.userId, {Key key}) : super(key: key);

  final String userId;

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    print(widget.userId);
    var currentUserId = FirebaseAuth.instance.currentUser.uid;
    print('above is the result');
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Chat').doc(widget.userId).collection('messages')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, chatSnapShot) {
        if (chatSnapShot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = chatSnapShot.data.docs;
        // print(chatDocs[0]['username']);
        print('0: 1: yes i am that one');
        return ListView.builder(
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (ctx, index) => MessageBubble(
            chatDocs[index]['text'],
            chatDocs[index]['username'],
            chatDocs[index]['userId'] == currentUserId,
            key: ValueKey(chatDocs[index]['userId']),
          ),
        );
      },
    );
  }
}
