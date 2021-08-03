import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Feed with ChangeNotifier{
  final String id;
  final String title;
  final String content;
  int likes;
  final Color color;
  final String createdOn;
  final String createdBy;
  final String profilePic;

  Feed({
    @required this.id,
    @required this.title,
    @required this.content,
    @required this.likes,
    @required this.color,
    @required this.createdOn,
    @required this.createdBy,
    @required this.profilePic,
  });
}
