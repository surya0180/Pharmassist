import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmassist/providers/auth/admin-provider.dart';
import 'package:pharmassist/providers/notification-provider.dart';
import 'package:pharmassist/providers/auth/user.dart';
import 'package:pharmassist/widgets/chat/UI/chat_item.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NotificationProvider>(context, listen: false).setTotalUserUnreadMessages();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _uid = FirebaseAuth.instance.currentUser.uid;
    final _isAdded =
        Provider.of<UserProvider>(context, listen: false).getIsAddedStatus;
    return _isAdded
        ? StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Chat')
                .doc(_uid)
                .snapshots(),
            builder: (ctx, listSnapShot) {
              if (listSnapShot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: const CircularProgressIndicator(),
                );
              }
              final listDocs = listSnapShot.data;
              return ListView(
                children: [
                  ChatItem(
                    Provider.of<AdminProvider>(context, listen: false)
                        .getAdminFullname,
                    Provider.of<AdminProvider>(context, listen: false)
                        .getAdminProfilePic,
                    listDocs['latestMessage'],
                    listDocs['hostB'],
                    listDocs['uid'],
                    listDocs['uidX']
                  ),
                ],
              );
            },
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.account_box,
                  size: 58,
                  color: Colors.black38,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: const Text(
                    'Please complete your profile to access this page',
                    style: const TextStyle(
                      color: Colors.black38,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
