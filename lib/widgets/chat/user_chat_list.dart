import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmassist/providers/admin-provider.dart';
import 'package:pharmassist/providers/notification-provider.dart';
import 'package:pharmassist/widgets/chat/chat_item.dart';
import 'package:provider/provider.dart';

class UserChatList extends StatefulWidget {
  const UserChatList({Key key}) : super(key: key);

  @override
  _UserChatListState createState() => _UserChatListState();
}

class _UserChatListState extends State<UserChatList> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<NotificationProvider>(context, listen: false).setTotalUserUnreadMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _uid = FirebaseAuth.instance.currentUser.uid;
    return StreamBuilder(
      stream:
          FirebaseFirestore.instance.collection('Chat').doc(_uid).snapshots(),
      builder: (ctx, listSnapShot) {
        if (listSnapShot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final listDocs = listSnapShot.data;
        return ListView(
          children: [
            ChatItem(
              Provider.of<AdminProvider>(context, listen: false).getAdminFullname,
              Provider.of<AdminProvider>(context, listen: false).getAdminProfilePic,
              listDocs['latestMessage'],
              listDocs['hostB'],
              listDocs['uid'],
            ),
          ],
        );
      },
    );
  }
}
