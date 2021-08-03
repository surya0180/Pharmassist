import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pharmassist/providers/feed.dart';

class FeedProvider with ChangeNotifier {
  void addFeed(Feed feed, String id) {
    var uid = FirebaseAuth.instance.currentUser.uid;
    FirebaseFirestore.instance.collection('feed/').doc(id).set({
      'id': feed.id,
      'title': feed.title,
      'content': feed.content,
      'likes': int.parse(feed.likes.toString()),
      'color': feed.color.toString(),
      'createdOn': feed.createdOn,
      'createdBy': feed.createdBy,
      'profilePic': feed.profilePic,
      'likedUsers': {
        '$uid': {
          'uid': '',
          'isLiked': false,
        }
      },
    });
  }

  void updateFeed(String id, String title, String content, DateTime updatedOn) {
    FirebaseFirestore.instance.collection('feed/').doc(id).update({
      'title': title,
      'content': content,
      'id': updatedOn.toIso8601String(),
      'createdOn': DateFormat.yMMMd().format(updatedOn),
    });
  }

  void addToLikedUsers(
      bool isLiked, String id, int likes, Map<String, dynamic> likedUsers) {
    var uid = FirebaseAuth.instance.currentUser.uid;
    likedUsers['$uid'] = {'uid': uid, 'isLiked': isLiked};
    if(isLiked) {
      likes = likes + 1;
    }
    else {
      likes = likes - 1;
    }
    FirebaseFirestore.instance.collection('feed/').doc(id).update({
      'likes': likes,
      'likedUsers': likedUsers,
    });
  }
}
