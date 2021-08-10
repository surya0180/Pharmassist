import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'UI/message_bubble.dart';

class Messages extends StatefulWidget {
  const Messages(this.userId, this.unreadMessages, this.isSent, this.timestamp, {Key key}) : super(key: key);

  final String userId;
  final int unreadMessages;
  final bool isSent;
  final String timestamp;

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
          .collection('Chat')
          .doc(widget.userId)
          .collection('messages')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, chatSnapShot) {
        if (chatSnapShot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = chatSnapShot.data.docs;
        print('0: 1: yes i am that one');
        return widget.unreadMessages == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                reverse: true,
                itemCount: chatDocs.length,
                itemBuilder: (ctx, index) {
                  print(index);
                  print(chatDocs[index]['text']);
                  print(widget.unreadMessages);
                  print('above are the unread messages');
                  if (index >= 0 && index < widget.unreadMessages) {
                    return MessageBubble(
                      chatDocs[index]['text'],
                      chatDocs[index]['username'],
                      chatDocs[index]['userId'] == currentUserId,
                      true,
                      chatDocs[index]['timestamp'],
                      chatDocs[index]['createdAt'],
                      true,
                      key: ValueKey(chatDocs[index]['userId']),
                    );
                  } else {
                    print(widget.timestamp);
                    print(chatDocs[index]['timestamp']);
                    return MessageBubble(
                      chatDocs[index]['text'],
                      chatDocs[index]['username'],
                      chatDocs[index]['userId'] == currentUserId,
                      false,
                      chatDocs[index]['timestamp'],
                      chatDocs[index]['createdAt'],
                      widget.timestamp == chatDocs[index]['sentAt'].toString() ? widget.isSent : true,
                      key: ValueKey(chatDocs[index]['userId']),
                    );
                  }
                },
              );
      },
    );
  }
}
