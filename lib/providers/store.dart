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
  final bool isNew;
  Timestamp timestamp;
  bool isDeletd;

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
    @required this.isNew,
    this.timestamp,
    this.isDeletd,
  });
}

class StoreProvider with ChangeNotifier {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  var signedUser = FirebaseAuth.instance.currentUser;

  void createStore(Store editedStore) {
    final uid = signedUser.uid;

    final document = FirebaseFirestore.instance
        .collection('stores')
        .doc(uid)
        .collection('sub Stores')
        .doc();
    final document2 =
        FirebaseFirestore.instance.collection('stores label').doc(document.id);

    document.set({
      'storeId': document.id,
      'uid': uid,
      'name': editedStore.name,
      'firmId': editedStore.firmId,
      'establishmentYear': editedStore.establishmentYear,
      'street': editedStore.street,
      'town': editedStore.town,
      'district': editedStore.district,
      'state': editedStore.state,
      'isNew': false,
      'isDeleted': false,
      'timeStamp': editedStore.timestamp,
    });
    document2.set({
      'storeId': document.id,
      'uid': uid,
      'name': editedStore.name.toLowerCase(),
      'firmId': editedStore.firmId,
      'establishmentYear': editedStore.establishmentYear,
      'street': editedStore.street.toLowerCase(),
      'town': editedStore.town.toLowerCase(),
      'district': editedStore.district.toLowerCase(),
      'state': editedStore.state.toLowerCase(),
      'isNew': false,
      'isDeleted': false,
      'timeStamp': editedStore.timestamp,
    });
  }

  void updateStore(Store editedStore) {
    final uid = signedUser.uid;

    FirebaseFirestore.instance
        .collection('stores')
        .doc(uid)
        .collection('sub Stores')
        .doc(editedStore.storeId)
        .update({
      'storeId': editedStore.storeId,
      'uid': editedStore.uid,
      'name': editedStore.name,
      'firmId': editedStore.firmId,
      'establishmentYear': editedStore.establishmentYear,
      'street': editedStore.street,
      'town': editedStore.town,
      'district': editedStore.district,
      'state': editedStore.state,
      'isNew': false,
      'isDeleted': false,
      'timeStamp': editedStore.timestamp,
    });
    FirebaseFirestore.instance
        .collection('stores label')
        .doc(editedStore.storeId)
        .update({
      'storeId': editedStore.storeId,
      'uid': editedStore.uid,
      'name': editedStore.name.toLowerCase(),
      'firmId': editedStore.firmId,
      'establishmentYear': editedStore.establishmentYear,
      'street': editedStore.street.toLowerCase(),
      'town': editedStore.town.toLowerCase(),
      'district': editedStore.district.toLowerCase(),
      'state': editedStore.state.toLowerCase(),
      'isNew': false,
      'isDeleted': false,
      'timeStamp': editedStore.timestamp,
    });
  }

  Future<void> deleteStore(Store editedStore) {
    final uid = signedUser.uid;
    print(editedStore.storeId);

    FirebaseFirestore.instance
        .collection('stores label')
        .doc(editedStore.storeId)
        .update({
      'isDeleted': true,
    });
    return FirebaseFirestore.instance
        .collection('stores')
        .doc(uid)
        .collection('sub Stores')
        .doc(editedStore.storeId)
        .update({
      'isDeleted': true,
    });
  }
}
