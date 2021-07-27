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
      createUserData(
        signedUser.uid,
        signedUser.email,
        signedUser.photoURL,
      );
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Future logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }

  Future<void> createUserData(String uid, String email, String photoUrl) async {
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
    });
  }

  Future updateUser(
    bool isAdded,
    String fullName,
    String reg,
    String ren,
    String street,
    String town,
    String district,
    String state,
  ) async {
    User signedUser = FirebaseAuth.instance.currentUser;
    return await users.doc(signedUser.uid).update({
      "isAdded": true,
    });
  }
}
