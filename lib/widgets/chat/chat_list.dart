import 'package:flutter/material.dart';
import 'package:pharmassist/helpers/ChatListinfo.dart';
import 'package:pharmassist/widgets/chat/chat_item.dart';

class ChatList extends StatelessWidget {
  const ChatList({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (ctx, index) => ChatItem(
        list[index]['name'],
        list[index]['message'],
        list[index]['msg_num']
      ),
    );
  }
}