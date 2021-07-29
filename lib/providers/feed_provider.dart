import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pharmassist/providers/feed.dart';

class FeedProvider with ChangeNotifier {
  void addFeed(Feed feed, String id) {
    FirebaseFirestore.instance.collection('feed/').doc(id).set({
      'id': feed.id,
      'title': feed.title,
      'content': feed.content,
      'likes': int.parse(feed.likes.toString()),
      'isLiked': feed.isLiked,
      'color': feed.color.toString(),
    });
  }

  void updateFeed(String id, String title, String content) {
    FirebaseFirestore.instance.collection('feed/').doc(id).update({
      'title': title,
      'content': content,
    });
  }

  void changeIsLikedStatus(bool isLiked, String id, int likes) {
    FirebaseFirestore.instance.collection('feed/').doc(id).update({
      'isLiked': !isLiked,
      'likes': !isLiked ? likes + 1 : likes - 1,
    });
  }

  Feed findById(id) {
    return Feed(
      color: Colors.amber,
      content: '',
      id: '',
      likes: 5,
      title: '',
      isLiked: false,
    );
  }
}
