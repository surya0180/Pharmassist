import 'package:flutter/material.dart';
import 'package:pharmassist/helpers/ChatListinfo.dart';
import 'package:pharmassist/providers/user.dart';
import 'package:pharmassist/widgets/chat/chat_item.dart';
import 'package:provider/provider.dart';

class ChatList extends StatelessWidget {
  const ChatList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _isAdmin =
        Provider.of<UserProvider>(context, listen: false).getIsAdminStatus;
    return ListView.builder(
      itemCount: _isAdmin ? adminList.length : userList.length,
      itemBuilder: (ctx, index) => _isAdmin
          ? ChatItem(adminList[index]['name'], adminList[index]['message'],
              adminList[index]['msg_num'])
          : ChatItem(userList[index]['name'], userList[index]['message'],
              userList[index]['msg_num']),
    );
  }
}
