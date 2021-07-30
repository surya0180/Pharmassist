import 'package:flutter/material.dart';
import 'package:pharmassist/widgets/chat/messages.dart';
import 'package:pharmassist/widgets/chat/new_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key key}) : super(key: key);

  static const routeName = '/chat-screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String userName;
  String userId;

  @override
  void didChangeDependencies() {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    userName = routeArgs['name'];
    userId = routeArgs['userId'];
    print(userName);
    print(userId);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          userName,
          style: Theme.of(context).textTheme.title,
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(userId),
            ),
            NewMessage(userId),
          ],
        ),
      ),
    );
  }
}
