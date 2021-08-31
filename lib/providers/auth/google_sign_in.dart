import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pharmassist/providers/NetworkNotifier.dart';
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
      } else {
        updateUserData(signedUser.uid);
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
    return Provider.of<NetworkNotifier>(context, listen: false)
        .setIsConnected()
        .then((value) {
      if (Provider.of<NetworkNotifier>(context, listen: false).getIsConnected) {
        return FirebaseFirestore.instance
            .collection('users')
            .doc(Provider.of<up.UserProvider>(context, listen: false).user.uid)
            .get()
            .then((snapShot) async {
          final fbm = FirebaseMessaging.instance;
          fbm.requestPermission();
          fbm.getToken().then((value) {
            print(value);
            var deviceData = snapShot.data()['deviceToken'];
            deviceData.remove(value);
            FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser.uid)
                .update({
              "deviceToken": deviceData,
            });
          });
          Provider.of<up.UserProvider>(context, listen: false).clearState();
          Provider.of<ProfileEditStatus>(context, listen: false).clearState();
          await googleSignIn.disconnect();
          return FirebaseAuth.instance.signOut();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 40),
            duration: Duration(seconds: 2),
            content: Text('Please check your connection'),
          ),
        );
      }
    });
  }

  void createUserData(
      String uid, String email, String photoUrl, String displayName) {
    final fbm = FirebaseMessaging.instance;
    fbm.requestPermission();
    fbm.getToken().then((value) {
      return users.doc(uid).set({
        "uid": uid,
        "deviceToken": [value],
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
        "state": "maharashtra",
        "displayName": displayName,
      });
    });
  }

  void updateUserData(String uid) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((snapShot) {
      final fbm = FirebaseMessaging.instance;
      fbm.requestPermission();
      fbm.getToken().then((value) {
        var deviceData = snapShot.data()['deviceToken'];
        deviceData.add(value);
        return users.doc(uid).update({
          "uid": uid,
          "deviceToken": deviceData,
        });
      });
    });
  }

  Future<void> createChatData() async {
    User signedUser = FirebaseAuth.instance.currentUser;

    final adminData = await FirebaseFirestore.instance
        .collection('admin')
        .doc('admin-details')
        .get();

    final timestamp = DateTime.now();
    final bucketId = timestamp.toIso8601String();

    FirebaseFirestore.instance
        .collection('chat')
        .doc(adminData.data()['uid'])
        .collection('chatList')
        .doc(signedUser.uid)
        .set({
      "bucketId": bucketId,
      "uid": signedUser.uid,
      "username": signedUser.displayName,
      "participants": [adminData.data()['uid'], signedUser.uid],
      "timestamp": null,
    });

    return FirebaseFirestore.instance
        .collection('chat')
        .doc(signedUser.uid)
        .collection('chatList')
        .doc(adminData.data()['uid'])
        .set({
      "bucketId": bucketId,
      "uid": adminData.data()['uid'],
      "username": adminData.data()['fullname'],
      "participants": [adminData.data()['uid'], signedUser.uid],
      "timestamp": timestamp,
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
