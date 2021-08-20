import 'package:flutter/material.dart';
import 'package:pharmassist/helpers/HasNetwork.dart';
import 'package:pharmassist/providers/auth/user.dart';
import 'package:pharmassist/widgets/chat/lists/admin_chat_list.dart';
import 'package:pharmassist/widgets/chat/lists/user_chat_list.dart';
import 'package:provider/provider.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key key}) : super(key: key);

  static const routeName = '/chat-screen';

  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  Widget build(BuildContext context) {
    var _isAdmin = Provider.of<UserProvider>(context, listen: false).getIsAdminStatus;

    return RefreshIndicator(
      onRefresh: Provider.of<NetworkNotifier>(context, listen: false).setIsConnected,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: _isAdmin ? const AdminChatList() : const UserChatList(),
      ),
    );
  }
}
