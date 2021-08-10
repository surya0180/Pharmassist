import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminProvider with ChangeNotifier {
  String profilePic;
  String fullname;
  String uid;
  int requestCount;

  Future<void> getAdminData() async {
    final adminData = await FirebaseFirestore.instance
        .collection('admin')
        .doc('admin-details')
        .get();
    profilePic = adminData.data()['profilePic'];
    fullname = adminData.data()['fullname'];
    uid = adminData.data()['uid'];
    requestCount = adminData.data()["requests"];
    notifyListeners();
  }

  String get getAdminProfilePic {
    return profilePic;
  }

  String get getAdminFullname {
    return fullname;
  }

  String get getAdminUid {
    return uid;
  }

  int get getAdminReq {
    return requestCount;
  }

  void updateRequests(int count) {
    FirebaseFirestore.instance.collection('admin').doc('admin-details').update({
      'requests': count,
    });
    if (count != 0) {
      requestCount = requestCount + 1;
    } else {
      requestCount = 0;
    }

    notifyListeners();
  }
}
