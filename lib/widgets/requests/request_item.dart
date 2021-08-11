import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmassist/screens/admin/request_detail_screen.dart';
import 'package:pharmassist/screens/chat/chat_screen.dart';

class RequestItem extends StatelessWidget {
  final String createdOn;
  final String about;
  final String request;
  final String uid;
  final String photoUrl;
  final String username;
  final String requestType;
  final String requestId;
  final bool isDeleted;

  RequestItem(
    this.createdOn,
    this.about,
    this.request,
    this.uid,
    this.photoUrl,
    this.username,
    this.requestType,
    this.requestId,
    this.isDeleted,
  );

  @override
  Widget build(BuildContext context) {
    if (isDeleted) {
      return Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 2,
        ),
        child: Padding(
          padding: EdgeInsets.all(4),
          child: ListTile(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(RequestDetailScreen.routeName, arguments: {
                'userName': username,
                'uid': uid,
                'createdOn': createdOn,
                'title': about,
                'detail': request,
                'photoUrl': photoUrl,
              });
            },
            leading: CircleAvatar(
              backgroundImage: NetworkImage(photoUrl),
            ),
            title: Text(about),
            subtitle: Text(createdOn),
          ),
        ),
      );
    }
    return Dismissible(
      key: ValueKey(createdOn),
      secondaryBackground: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      background: Container(
        color: Colors.green,
        child: Icon(
          Icons.chat,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      // direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        if (direction == DismissDirection.endToStart) {
          return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text('Are you sure?'),
              content: Text(
                'Confirm to delete the request?',
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.of(ctx).pop(false);
                  },
                ),
                FlatButton(
                  child: Text('Yes'),
                  onPressed: () {
                    Navigator.of(ctx).pop(true);
                  },
                ),
              ],
            ),
          );
        } else {
          return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text('Are you sure?'),
              content: Text(
                'Do you want to chat with this person about the request',
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.of(ctx).pop(false);
                  },
                ),
                FlatButton(
                  child: Text('Yes'),
                  onPressed: () {
                    Navigator.of(ctx).pop(false);
                    Navigator.of(ctx).pushNamed(ChatScreen.routeName,
                        arguments: {'name': username, 'userId': uid});
                  },
                ),
              ],
            ),
          );
        }

        //write logic above for exact location
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          CollectionReference<Map<String, dynamic>> collection;
          if (requestType == "pharm") {
            collection =
                FirebaseFirestore.instance.collection('pharmacist requests');
          } else {
            collection =
                FirebaseFirestore.instance.collection('medical requests');
          }
          collection.doc(requestId).update({'isDeleted': true});
        }
      },
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 2,
        ),
        child: Padding(
          padding: EdgeInsets.all(4),
          child: ListTile(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(RequestDetailScreen.routeName, arguments: {
                'userName': username,
                'uid': uid,
                'createdOn': createdOn,
                'title': about,
                'detail': request,
                'photoUrl': photoUrl,
              });
            },
            leading: CircleAvatar(
              backgroundImage: NetworkImage(photoUrl),
            ),
            title: Text(about),
            subtitle: Text(createdOn),
          ),
        ),
      ),
    );
  }
}
