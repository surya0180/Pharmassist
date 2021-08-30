import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmassist/providers/notification-provider.dart';
import 'package:pharmassist/widgets/chat/UI/chat_item.dart';
import 'package:provider/provider.dart';

class AdminChatList extends StatefulWidget {
  const AdminChatList({Key key}) : super(key: key);

  @override
  _AdminChatListState createState() => _AdminChatListState();
}

class _AdminChatListState extends State<AdminChatList> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NotificationProvider>(context, listen: false)
          .setTotalUnreadMessages(0);
    });
    super.initState();
  }

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
          return const Center(
            child: const CircularProgressIndicator(),
          );
        }
        final listDocs = listSnapShot.data.docs;
        return ListView.builder(
          itemCount: listDocs.length,
          itemBuilder: (ctx, index) {
            if (listDocs[index]['latestMessage'] != '') {
              return ChatItem(
                listDocs[index]['name'],
                listDocs[index]['profilePic'],
                listDocs[index]['latestMessage'],
                listDocs[index]['hostA'],
                listDocs[index]['uid'],
                listDocs[index]['uidX'],
              );
            }
            return const SizedBox(
              height: 0,
            );
          },
        );
      },
    );
  }
}
