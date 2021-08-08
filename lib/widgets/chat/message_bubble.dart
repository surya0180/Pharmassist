import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(this.message, this.username, this.isMe, this.unread,
      this.timestamp, this.day, this.isSent,
      {this.key});

  final String message;
  final bool isMe;
  final Key key;
  final String username;
  final bool unread;
  final String timestamp;
  final Timestamp day;
  final bool isSent;

  @override
  Widget build(BuildContext context) {
    var chatTimestamp =
        DateTime.fromMillisecondsSinceEpoch(day.millisecondsSinceEpoch);
    var currentTimestamp = DateTime.fromMillisecondsSinceEpoch(
        Timestamp.now().millisecondsSinceEpoch);
    var cts = DateFormat('MMM-dd').format(chatTimestamp);
    var cuts = DateFormat('MMM-dd').format(currentTimestamp);
    String chatTime;
    if (cts == cuts) {
      chatTime = timestamp;
    } else {
      chatTime = cts + ' ' + timestamp;
    }
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  color: isMe
                      ? isSent != null
                          ? isSent
                              ? Colors.grey[300]
                              : Colors.black38
                          : Colors.grey[300]
                      : unread
                          ? Colors.green[300]
                          : Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft:
                        !isMe ? Radius.circular(0) : Radius.circular(12),
                    bottomRight:
                        isMe ? Radius.circular(0) : Radius.circular(12),
                  ),
                ),
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width * 0.3,
                  maxWidth: MediaQuery.of(context).size.width * 0.85,
                ),
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
                    Text(
                      username,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isMe
                            ? Colors.black
                            : Theme.of(context).accentTextTheme.title.color,
                      ),
                    ),
                    Text(
                      message,
                      softWrap: true,
                      style: TextStyle(
                        color: isMe
                            ? Colors.black
                            : Theme.of(context).accentTextTheme.title.color,
                      ),
                      textAlign: isMe ? TextAlign.end : TextAlign.start,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.008,
                    ),
                    Text(
                      '$chatTime',
                      style: TextStyle(fontSize: 12, color: Colors.black38),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
      clipBehavior: Clip.none,
    );
  }
}
