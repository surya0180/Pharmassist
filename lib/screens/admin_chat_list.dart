import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmassist/widgets/chat/chat_item.dart';

class AdminChatList extends StatefulWidget {
  const AdminChatList({Key key}) : super(key: key);

  @override
  _AdminChatListState createState() => _AdminChatListState();
}

class _AdminChatListState extends State<AdminChatList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Chat')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      initialData: "ture",
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
            print(listDocs[index]['latestMessage']);
            if (listDocs[index]['latestMessage'] != '') {
              return ChatItem(
                listDocs[index]['name'],
                listDocs[index]['latestMessage'],
                listDocs[index]['hostB'],
                listDocs[index]['uid'],
              );
            }
            return SizedBox(height: 0,);
          },
        );
      },
    );
  }
}
