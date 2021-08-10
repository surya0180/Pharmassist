import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Comment with ChangeNotifier{
  final String id;
  final String username;
  final String comment;

  Comment({
    @required this.id,
    @required this.username,
    @required this.comment,
  });
}
