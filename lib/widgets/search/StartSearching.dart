import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'StoreSearchResults.dart';
import 'UserSearchResult.dart';
import '../../helpers/string_extension.dart';

class StartSearching extends StatelessWidget {
  String _category;
  StartSearching(this._category);

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context).size;
    return StreamBuilder(
      stream:
          _category == null || _category == 'noFilter' || _category == 'pharms'
              ? FirebaseFirestore.instance
                  .collection('users')
                  .where('isAdded', isEqualTo: true)
                  .where('isAdmin', isEqualTo: false)
                  .orderBy('fullName')
                  .snapshots()
              : FirebaseFirestore.instance
                  .collection('stores label')
                  .where('isDeleted', isEqualTo: false)
                  .orderBy('name')
                  .snapshots(),
      builder: (ctx, snapShot) {
        if (snapShot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final docs = snapShot.data.docs;
        return ListView.builder(
          shrinkWrap: true,
          itemCount: docs.length,
          itemBuilder: (ctx, index) {
            return _category == null ||
                    _category == 'noFilter' ||
                    _category == 'pharms'
                ? UserSearchResult(
                    fullname: docs[index]['fullName'].toString().capitalize(),
                    profilePic: docs[index]['PhotoUrl'],
                    registerationNumber: docs[index]['registrationNo'],
                    district: docs[index]['district'],
                    state: docs[index]['state'],
                    renewalDate: docs[index]['renewalDate'],
                    street: docs[index]['street'],
                    town: docs[index]['town'],
                    uid: docs[index]['uid'],
                  )
                : StoreSearchResult(
                    name: docs[index]['name'].toString().capitalize(),
                    storeId: docs[index]['storeId'],
                    district: docs[index]['district'].toString().capitalize(),
                    state: docs[index]['state'].toString().capitalize(),
                    street: docs[index]['street'].toString().capitalize(),
                    town: docs[index]['town'].toString().capitalize(),
                    establishmentYear: docs[index]['establishmentYear'],
                    firmId: docs[index]['firmId'],
                    timestamp: docs[index]['timeStamp'],
                    uid: docs[index]['uid'],
                  );
          },
        );
      },
    );
  }
}
