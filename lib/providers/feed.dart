import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Feed with ChangeNotifier{
  final String id;
  final String title;
  final String content;
  int likes;
  final Color color;
  final DateTime createdOn;
  DateTime updatedOn;

  Feed({
    @required this.id,
    @required this.title,
    @required this.content,
    @required this.likes,
    @required this.color,
    @required this.createdOn,
    this.updatedOn,
  });
}
