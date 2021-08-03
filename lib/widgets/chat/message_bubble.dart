import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(this.message, this.username, this.isMe, {this.key});

  final String message;
  final bool isMe;
  final Key key;
  final String username;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                  bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
                ),
              ),
              constraints: BoxConstraints(minWidth: 100),
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              margin: EdgeInsets.symmetric(
                vertical: 1,
                horizontal: 8,
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  isMe
                      ? Text(
                          username,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isMe
                                ? Colors.black
                                : Theme.of(context).accentTextTheme.title.color,
                          ),
                        )
                      : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              username,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isMe
                                    ? Colors.black
                                    : Theme.of(context)
                                        .accentTextTheme
                                        .title
                                        .color,
                              ),
                            ),
                            SizedBox(width: 10,),
                            Text(
                              '2:22 PM',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black38),
                            ),
                          ],
                        ),
                  Text(
                    message,
                    style: TextStyle(
                      color: isMe
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.title.color,
                    ),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  if (isMe)
                    Row(
                      mainAxisAlignment: isMe
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        Text(
                          '2:22 PM',
                          style: TextStyle(fontSize: 12, color: Colors.black38),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ],
      clipBehavior: Clip.none,
    );
  }
}
