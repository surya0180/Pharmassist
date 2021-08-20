import 'package:flutter/material.dart';
import 'package:pharmassist/screens/chat/chat_screen.dart';
import '../../../helpers/string_extension.dart';

class ChatItem extends StatelessWidget {
  const ChatItem(
      this.name, this.profilePic, this.message, this.number, this.uid, this.uidX,
      {Key key})
      : super(key: key);

  final String name;
  final String message;
  final int number;
  final String uid;
  final String uidX;
  final String profilePic;

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
              'name': name.capitalize(),
              'userId': uid,
              'uidX': uidX,
            },
          );
        },
        splashColor: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          height: MediaQuery.of(context).size.height*0.1,
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue[200],
                    backgroundImage: NetworkImage(profilePic),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.05,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name.capitalize(),
                        style: Theme.of(context).textTheme.title,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.008,
                      ),
                      number != 0
                          ? Text(
                              message.length > 20 ? message.substring(0, 20) + '. . . .' : message,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.blue),
                            )
                          : Text(message.length > 25 ? message.substring(0, 25) + '. . . .' : message,),
                    ],
                  ),
                ],
              ),
              number != 0
                  ? CircleAvatar(
                      minRadius: 12,
                      backgroundColor: Colors.green[300],
                      child: Text(
                        '$number',
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
