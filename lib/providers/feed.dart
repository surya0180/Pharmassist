import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Feed with ChangeNotifier{
  final String id;
  final String title;
  final String content;
  int likes;
  final Color color;
  bool isLiked;

  Feed({
    @required this.id,
    @required this.title,
    @required this.content,
    @required this.likes,
    @required this.color,
    this.isLiked = false,
  });
}
