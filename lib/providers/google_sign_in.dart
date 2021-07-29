import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  Future logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
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
      "state": "",
      "displayName": displayName,
    });
  }
}
