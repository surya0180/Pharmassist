import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RequestItem extends StatelessWidget {
  final String createdOn;
  final String about;
  final String request;
  final String uid;
  final String photoUrl;
  final String username;
  final String requestType;
  final String requestId;

  RequestItem(
    this.createdOn,
    this.about,
    this.request,
    this.uid,
    this.photoUrl,
    this.username,
    this.requestType,
    this.requestId,
  );

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(createdOn),
      background: Container(
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
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text(
              'Do you want to remove the item from the cart?',
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
      },
      onDismissed: (direction) {
        CollectionReference<Map<String, dynamic>> collection;
        if (requestType == "pharm") {
          collection =
              FirebaseFirestore.instance.collection('pharmacist requests');
        } else {
          collection =
              FirebaseFirestore.instance.collection('medical requests');
        }
        collection.doc(requestId).delete();
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Image.network(photoUrl),
              ),
            ),
            title: Text(about),
            subtitle: Text(createdOn),
          ),
        ),
      ),
    );
  }
}