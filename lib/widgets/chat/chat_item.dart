import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pharmassist/helpers/Colors.dart';
import 'package:pharmassist/helpers/SampleMessages.dart';
import 'package:pharmassist/screens/chat_screen.dart';

class ChatItem extends StatelessWidget {
  const ChatItem(this.name, this.message, this.number, {Key key})
      : super(key: key);

  final String name;
  final String message;
  final int number;

  @override
  Widget build(BuildContext context) {
    Color _generateRandomColor() {
      var rc = Random();
      return themeColors[rc.nextInt(10)];
    }

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.black26),
        ),
      ),
      child: InkWell(
        onTap: () {
          print("I tapped this");
          Navigator.of(context).pushNamed(
            ChatScreen.routeName,
            arguments: {
              'name': name,
              'messages': sample,
            },
          );
        },
        splashColor: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          height: 73,
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Row(
            children: [
              number != 0
                  ? CircleAvatar(
                      backgroundColor: Colors.green[300],
                      child: Text(
                        '$number',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    )
                  : CircleAvatar(
                      backgroundColor: Colors.blue[200],
                      child: Icon(Icons.check),
                    ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(message),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
