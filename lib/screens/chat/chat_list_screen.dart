import 'package:flutter/material.dart';
import 'package:pharmassist/providers/NetworkNotifier.dart';
import 'package:pharmassist/providers/auth/user.dart';
import 'package:pharmassist/widgets/chat/UI/chat_list.dart';
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
    var _isAdded =
        Provider.of<UserProvider>(context, listen: false).getIsAddedStatus;

    final device = MediaQuery.of(context).size;

    return RefreshIndicator(
      onRefresh:
          Provider.of<NetworkNotifier>(context, listen: false).setIsConnected,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: _isAdded
            ? ChatList()
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
                      height: device.height * 0.02,
                    ),
                    Container(
                      width: device.width * 0.6,
                      child: const Text(
                        'Please complete your profile to access this page',
                        style: TextStyle(
                          color: Colors.black38,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
