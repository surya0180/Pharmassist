import 'package:flutter/material.dart';
import './message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages(this.messages, {Key key}) : super(key: key);

  final List messages;

  @override
  Widget build(BuildContext context) {
    String userId = '2';

    return ListView.builder(
      reverse: true,
      itemCount: 2,
      itemBuilder: (ctx, index) => MessageBubble(
        messages[index]['text'],
        messages[index]['username'],
        messages[index]['uid'] == userId,
        key: ValueKey(messages[index]['uid']),
      ),
    );
  }
}
