import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class NotificationProvider with ChangeNotifier {
  int totalUnreadMessages;
  int totalUserUnreadMessages;

  Future<void> calculateTotalUnreadMessages() async {
    final chatData = await FirebaseFirestore.instance
        .collection('chat')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('chatList')
        .get();
    int flag = 0;
    chatData.docs.forEach((element) {
      flag = flag + element.data()['unreadMessages'];
    });

    totalUnreadMessages = flag;
    notifyListeners();
  }

  int get getTotalUnreadMessages {
    return totalUnreadMessages;
  }

  void setTotalUnreadMessages(int unreadMessages) {
    totalUnreadMessages = totalUnreadMessages - unreadMessages;
    notifyListeners();
  }
}
