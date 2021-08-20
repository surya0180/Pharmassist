import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../../helpers/string_extension.dart';

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
  User _user;

  User get user {
    return _user;
  }

  dynamic get getIsAdminStatus {
    if (_user == null) {
      return null;
    }
    return _user.isAdmin;
  }

  bool get getIsAddedStatus {
    if (_user == null) {
      return null;
    }
    return _user.isAdded;
  }

  Future<bool> getData() async {
    final _uid = FirebaseAuth.instance.currentUser.uid;
    final _userData =
        await FirebaseFirestore.instance.collection('users/').doc(_uid).get();
    if (_userData.data() == null) {
      return false;
    }
    _user = User(
      isAdded: _userData.data()['isAdded'],
      isAdmin: _userData.data()['isAdmin'],
      uid: _userData.data()['uid'],
      fullname: _userData.data()['fullName'].toString().capitalize(),
      registrationNo: _userData.data()['registrationNo'],
      renewalDate: _userData.data()['renewalDate'],
      street: _userData.data()['street'].toString().capitalize(),
      town: _userData.data()['town'].toString().capitalize(),
      district: _userData.data()['district'].toString().capitalize(),
      state: _userData.data()['state'].toString().capitalize(),
      email: _userData.data()['email'],
      photoUrl: _userData.data()['PhotoUrl'],
    );
    notifyListeners();
    return true;
  }

  Future updateUser(
    User newUser,
  ) async {
    _user = User(
      isAdded: newUser.isAdded,
      isAdmin: _user.isAdmin,
      uid: _user.uid,
      fullname: newUser.fullname,
      registrationNo: newUser.registrationNo,
      renewalDate: newUser.renewalDate,
      street: newUser.street,
      town: newUser.town,
      district: newUser.district,
      state: newUser.state,
      email: _user.email,
      photoUrl: _user.photoUrl,
    );
    notifyListeners();
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update({
      "isAdded": true,
      "fullName": newUser.fullname.toLowerCase(),
      "registrationNo": newUser.registrationNo,
      "renewalDate": newUser.renewalDate,
      "street": newUser.street.toLowerCase(),
      "town": newUser.town.toLowerCase(),
      "district": newUser.district.toLowerCase(),
      "state": newUser.state.toLowerCase(),
    });
  }

  void clearState() {
    _user = null;
    notifyListeners();
  }
}
