import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmassist/widgets/chat/chat_item.dart';

class AdminChatList extends StatelessWidget {
  const AdminChatList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Chat')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (ctx, listSnapShot) {
        if (listSnapShot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final listDocs = listSnapShot.data.docs;
        return ListView.builder(
          itemCount: listDocs.length,
          itemBuilder: (ctx, index) {
            return listDocs[index]['latestMessage'] != "" ? ChatItem(
              listDocs[index]['name'],
              listDocs[index]['latestMessage'],
              listDocs[index]['HostA'],
              listDocs[index]['uid'],
            ) : null;
          },
        );
      },
    );
  }
}
