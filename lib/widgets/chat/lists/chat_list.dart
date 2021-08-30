import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmassist/providers/notification-provider.dart';
import 'package:pharmassist/widgets/chat/UI/chat_item.dart';
import 'package:pharmassist/widgets/chat/UI/new_chat_item.dart';
import 'package:provider/provider.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key key}) : super(key: key);

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection('chatList')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (ctx, listSnapShot) {
        if (listSnapShot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: const CircularProgressIndicator(),
          );
        }
        final listDocs = listSnapShot.data.docs;
        // print(listDocs[0]['bucketId']);
        return ListView.builder(
          itemCount: listDocs.length,
          itemBuilder: (ctx, index) {
            return NewChatItem(
              listDocs[index]['bucketId'],
              listDocs[index]['participants'],
              listDocs[index]['uid'],
              listDocs[index]['username'],
              listDocs[index]['unreadMessages'],
              listDocs[index]['profilePic'],
              listDocs[index]['latestMessage'],
            );
          },
        );
      },
    );
  }
}
