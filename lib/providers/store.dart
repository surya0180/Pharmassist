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
  });
}

class StoreProvider with ChangeNotifier {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  var signedUser = FirebaseAuth.instance.currentUser;

  List<Store> _stores = [];

  Future<bool> getStoreData() async {
    List<Store> _temp = [];
    final _uid = FirebaseAuth.instance.currentUser.uid;
    final _userStoreData = await FirebaseFirestore.instance
        .collection('stores')
        .doc(_uid)
        .collection('sub Stores')
        .orderBy('timeStamp', descending: true)
        .get();

    _userStoreData.docs.forEach((doc) {
      if (doc.data() == null) {
        print("false statement");
        return false;
      }

      _temp.add(Store(
        name: doc.data()["name"],
        uid: doc.data()["uid"],
        storeId: doc.data()["storeId"],
        firmId: doc.data()["firmId"],
        establishmentYear: doc.data()["establishmentYear"],
        street: doc.data()["street"],
        town: doc.data()["town"],
        district: doc.data()["district"],
        state: doc.data()["state"],
        isNew: doc.data()["isNew"],
      ));
    });
    _stores = _temp;
    notifyListeners();

    return true;
  }

  Future<void> createStore(Store editedStore) async {
    final uid = signedUser.uid;
    var timeStamp = DateTime.now();
    final document = FirebaseFirestore.instance
        .collection('stores')
        .doc(uid)
        .collection('sub Stores')
        .doc();
    return await document.set({
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
      'timeStamp': timeStamp,
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
    print(_stores[0].storeId);
    print(id);
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
