import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class NotificationProvider with ChangeNotifier {
  int totalUnreadMessages;
  int totalUserUnreadMessages;

  Future<void> calculateTotalUnreadMessages() async {
    final chatData = await FirebaseFirestore.instance.collection('Chat').get();
    int flag = 0;
    chatData.docs.forEach((element) {
      flag = flag + element.data()['hostA'];
      if(element.data()['uid'] == FirebaseAuth.instance.currentUser.uid) {
        totalUserUnreadMessages = element.data()['hostB'];
      }
    });
    totalUnreadMessages = flag;
    notifyListeners();
  }

  int get getTotalUnreadMessages {
    return totalUnreadMessages;
  }

  int get getTotalUserUnreadMessages {
    return totalUserUnreadMessages;
  }

  void setTotalUnreadMessages() {
    totalUnreadMessages = 0;
    notifyListeners();
  }

  void setTotalUserUnreadMessages() {
    totalUserUnreadMessages = 0;
    notifyListeners();
  }
}