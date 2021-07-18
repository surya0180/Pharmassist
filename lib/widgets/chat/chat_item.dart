import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  const ChatItem(this.name, this.message, this.number, {Key key})
      : super(key: key);

  final String name;
  final String message;
  final int number;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      elevation: 3,
      child: InkWell(
        onTap: () {},
        splashColor: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          height: 73,
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
              if (number != 0)
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Theme.of(context).accentColor,
                  child: Text(
                    '$number',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
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
