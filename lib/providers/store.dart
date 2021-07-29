import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class Store {
  final String name;
  String uid;
  String storeId;
  final String firmId;
  final String establishmentYear;
  final String street;
  final String town;
  final String district;
  final String state;

  Store({
    this.uid,
    this.storeId,
    @required this.name,
    @required this.firmId,
    @required this.establishmentYear,
    @required this.street,
    @required this.town,
    @required this.district,
    @required this.state,
  });
}

class UserProvider with ChangeNotifier {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  var signedUser = FirebaseAuth.instance.currentUser;

  User _user;
  List<Store> _stores;
  User get user {
    return _user;
  }

  // bool get getIsAdminStatus {
  //   return _user.isAdmin;
  // }

  // bool get getIsAddedStatus {
  //   return _user.isAdded;
  // }

  Future getStoreData() async {
    final _uid = FirebaseAuth.instance.currentUser.uid;
    final _userStoreData = await FirebaseFirestore.instance
        .collection('stores')
        .doc(_uid)
        .collection('subStores')
        .get();
    _userStoreData.docs.forEach((doc) {
      _stores.add(Store(
        name: doc.data()["name"],
        uid: doc.data()["uid"],
        storeId: doc.data()["storeId"],
        firmId: doc.data()["firmId"],
        establishmentYear: doc.data()["establishmentYear"],
        street: doc.data()["street"],
        town: doc.data()["town"],
        district: doc.data()["district"],
        state: doc.data()["state"],
      ));
    });

    notifyListeners();
  }

  Future<void> createStore(
      String uid, String email, String photoUrl, String displayName) async {
    final uid = signedUser.uid;
    final document = FirebaseFirestore.instance
        .collection('stores')
        .doc(uid)
        .collection('subStores')
        .doc();
    return await document.set({
      'storeId': document.id,
      'uid': uid,
      'name': "Data",
      'firmId': "Data",
      'establishmentYear': "Data",
      'street': "Data",
      'town': "Data",
      'district': "Data",
      'state': "Data",
    }).then((onValue) {
      print('Created it in sub collection');
    }).catchError((e) {
      print('======Error======== ' + e);
    });
  }

  List<Store> get stores {
    //write code for filters here
    return [..._stores];
  }

  Store findById(String id) {
    return _stores.firstWhere((store) => store.storeId == id);
  }

  // Future updateUser(
  //   User newUser,
  // ) async {
  //   return await users.doc(signedUser.uid).update({
  //     "isAdded": true,
  //     "fullName": newUser.fullname,
  //     "registrationNo": newUser.registrationNo,
  //     "renewalDate": newUser.renewalDate,
  //     "street": newUser.street,
  //     "town": newUser.town,
  //     "district": newUser.district,
  //     "state": newUser.state,
  //   });
  // }
}
