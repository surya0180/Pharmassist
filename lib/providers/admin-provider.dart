import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminProvider with ChangeNotifier {
  String profilePic;
  String fullname;
  String uid;

  Future<void> getAdminData() async {
    final adminData = await FirebaseFirestore.instance.collection('admin').doc('admin-details').get();
    profilePic = adminData.data()['profilePic'];
    fullname = adminData.data()['fullname'];
    uid = adminData.data()['uid'];
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
}