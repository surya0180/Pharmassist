import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pharmassist/providers/profileEditStatus.dart';
import 'package:pharmassist/providers/auth/user.dart' as up;
import 'package:provider/provider.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount _user;
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  GoogleSignInAccount get user => _user;
  Future googleLogIn() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      User signedUser = FirebaseAuth.instance.currentUser;
      var doc = await users.doc(signedUser.uid).get();
      var isExist = doc.exists;
      if (!isExist) {
        createUserData(signedUser.uid, signedUser.email, signedUser.photoURL,
            signedUser.displayName);
        createChatData();
        createStoreData();
      }
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Future<bool> isDocExist() async {
    User signedUser = FirebaseAuth.instance.currentUser;
    var doc = await users.doc(signedUser.uid).get();
    var isExist = doc.exists;
    return isExist;
  }

  Future logout(BuildContext context) async {
    Provider.of<up.UserProvider>(context, listen: false).clearState();
    Provider.of<ProfileEditStatus>(context, listen: false).clearState();
    await googleSignIn.disconnect();
    return FirebaseAuth.instance.signOut();
  }

  Future<void> createUserData(
      String uid, String email, String photoUrl, String displayName) async {
    return await users.doc(uid).set({
      'uid': uid,
      "email": email,
      "PhotoUrl": photoUrl,
      "fullName": "",
      "isAdmin": false,
      "isAdded": false,
      "registrationNo": "",
      "renewalDate": "",
      "street": "",
      "town": "",
      "district": "",
      "state": "andhra pradesh",
      "displayName": displayName,
    });
  }

  Future<void> createChatData() async {
    User signedUser = FirebaseAuth.instance.currentUser;

    final CollectionReference chat =
        FirebaseFirestore.instance.collection('Chat');
    print("create chat is running");
    return await chat.doc(signedUser.uid).set({
      "hostA": 0,
      "hostB": 0,
      "latestMessage": "",
      "name": "",
      "timestamp": null,
      "uid": signedUser.uid,
    });
  }

  Future<void> createStoreData() async {
    User signedUser = FirebaseAuth.instance.currentUser;
    var timeStamp = DateTime.now();
    final store = FirebaseFirestore.instance
        .collection('stores')
        .doc(signedUser.uid)
        .collection("sub Stores")
        .doc();

    return await store.set({
      'storeId': store.id,
      'uid': signedUser.uid,
      'name': "",
      'firmId': "",
      'establishmentYear': "",
      'street': "",
      'town': "",
      'district': "",
      'state': "",
      'isNew': true,
      'isDeleted': false,
      'timeStamp': timeStamp,
    });
  }
}
