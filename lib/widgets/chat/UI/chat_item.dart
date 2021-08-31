import 'package:flutter/material.dart';
import 'package:pharmassist/screens/chat/chat_screen.dart';
import '../../../helpers/string_extension.dart';

class NewChatItem extends StatelessWidget {
  const NewChatItem(
    this.bucketId,
    this.participants,
    this.uid,
    this.username,
    this.unreadMessages,
    this.profilePic,
    this.latestMessage, {
    Key key,
  }) : super(key: key);

  final String bucketId;
  final List participants;
  final String uid;
  final String username;
  final int unreadMessages;
  final String profilePic;
  final String latestMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: const Border(
          bottom: const BorderSide(width: 1.0, color: Colors.black26),
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            ChatScreen.routeName,
            arguments: {
              'username': username.capitalize(),
              'uid': uid,
              'bucketId': bucketId,
              'participants': participants,
              'unreadMessages': unreadMessages,
            },
          );
        },
        splashColor: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.1,
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue[200],
                    backgroundImage: profilePic != null ? NetworkImage(profilePic) : null,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username.capitalize(),
                        style: Theme.of(context).textTheme.title,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.008,
                      ),
                      unreadMessages != 0
                          ? Text(
                              latestMessage.length > 20
                                  ? latestMessage.substring(0, 20) + '. . . .'
                                  : latestMessage,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.blue,
                              ),
                            )
                          : Text(
                              latestMessage.length > 25
                                  ? latestMessage.substring(0, 25) + '. . . .'
                                  : latestMessage,
                            ),
                    ],
                  ),
                ],
              ),
              unreadMessages != 0
                  ? CircleAvatar(
                      minRadius: 12,
                      backgroundColor: Colors.green[300],
                      child: Text(
                        '$unreadMessages',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    )
                  : const SizedBox(
                      height: 0,
                      width: 0,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
