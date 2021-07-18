import 'package:flutter/material.dart';
import './message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      itemCount: 4,
      itemBuilder: (ctx, index) => MessageBubble(
        'Hi there',
        'surya0180',
        true,
        key: ValueKey('Hi there'),
      ),
    );
  }
}
