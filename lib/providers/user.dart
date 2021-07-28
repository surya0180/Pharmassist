import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:pharmassist/helpers/user_info.dart';

class User {
  bool isAdded;
  bool isAdmin;
  final String uid;
  final String fullname;
  final String registrationNo;
  final String renewalDate;
  final String street;
  final String town;
  final String district;
  final String state;
  final String email;
  final String photoUrl;
  User({
    this.isAdded,
    this.isAdmin,
    this.uid,
    @required this.fullname,
    @required this.registrationNo,
    @required this.renewalDate,
    @required this.street,
    @required this.town,
    @required this.district,
    @required this.state,
    this.email,
    this.photoUrl,
  });
}

class UserProvider with ChangeNotifier {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  var signedUser = FirebaseAuth.instance.currentUser;

  Map<String, dynamic> _user;

  Map<String, dynamic> get user {
    return _user;
  }

  Future getData() async {
    final _uid = FirebaseAuth.instance.currentUser.uid;
    final _userData =
        await FirebaseFirestore.instance.collection('users/').doc(_uid).get();
    _user = _userData.data();
    notifyListeners();
  }

  Future updateUser(
    User newUser,
  ) async {
    // _user = newUser;
    // notifyListeners();
    return await users.doc(signedUser.uid).update({
      "isAdded": true,
      "fullName": newUser.fullname,
      "registrationNo": newUser.registrationNo,
      "renewalDate": newUser.renewalDate,
      "street": newUser.street,
      "town": newUser.town,
      "district": newUser.district,
      "state": newUser.state,
    });
  }
}
