import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pharmassist/providers/comment.dart';

class CommentProvider with ChangeNotifier {
  Map<String, List<Comment>> _commentSets = {
    'f1': [
      Comment(
        id: 'c1',
        username: 'vinod',
        comment: 'Here i commented some time ago',
      ),
      Comment(
        id: 'c1',
        username: 'binod',
        comment: 'sun is getting real low',
      ),
      Comment(
        id: 'c1',
        username: 'promodh',
        comment: 'I wont hurt you anymore',
      )
    ],
    'f2': [
      Comment(
        id: 'c1',
        username: 'vinod',
        comment: 'no one will hurt you anymore',
      ),
      Comment(
        id: 'c1',
        username: 'binod',
        comment: 'hey big guy',
      ),
      Comment(
        id: 'c1',
        username: 'promodh',
        comment: 'the earth is closed today',
      )
    ],
    'f3': [
      Comment(
        id: 'c1',
        username: 'vinod',
        comment: 'please be the children of thanos',
      ),
      Comment(
        id: 'c1',
        username: 'binod',
        comment: 'perfectly balenced',
      ),
      Comment(
        id: 'c1',
        username: 'promodh',
        comment: 'the stock was amazing',
      )
    ],
    'f4': [],
    'f5': [],
    'f6': [],
  };

  Map<String, List<Comment>> get comments {
    return {..._commentSets};
  }

  List<Comment> findById(String id) {
    for (var i = 0; i < _commentSets.length; i++) {
      String key = _commentSets.keys.elementAt(i);
      if (key == id) {
        return [..._commentSets[key].reversed];
      }
    }
  }

  void addComment(String id, Comment c) {
    for (var i = 0; i < _commentSets.length; i++) {
      String key = _commentSets.keys.elementAt(i);
      if (key == id) {
        _commentSets[key].add(c);
      }
    }
    notifyListeners();
  }

  void addCommentSection(String id, List<Comment> cnt) {
    _commentSets['$id'] = cnt;
    notifyListeners();
  }
}
