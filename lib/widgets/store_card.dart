import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmassist/screens/store_detail_screen.dart';

class StoreCard extends StatelessWidget {
  final String uid;
  final String storeId;
  final String name;
  final String firmId;
  final String establishmentYear;
  final String street;
  final String town;
  final String district;
  final String state;
  final bool isNew;
  final Timestamp timestamp;

  StoreCard(
    this.uid,
    this.storeId,
    this.name,
    this.firmId,
    this.establishmentYear,
    this.street,
    this.town,
    this.district,
    this.state,
    this.isNew,
    this.timestamp,
  );

  @override
  Widget build(BuildContext context) {
    print(isNew);
    return Container(
      height: MediaQuery.of(context).size.height*0.3,
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              StoreDetailScreen.routeName,
              arguments: {
                'uid': uid,
                'storeId': storeId,
                'name': name,
                'firmId': firmId,
                'establishmentYear': establishmentYear,
                'street': street,
                'town': town,
                'district': district,
                'state': state,
                'isNew': isNew,
                'timestamp': timestamp,
              },
            );
          },
          child: isNew
              ? Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Add Store"),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.02,
                      ),
                      Icon(Icons.add),
                    ],
                  ),
                )
              : Card(
                  child: Center(child: Text(name)),
                ),
        ),
      ),
    );
  }
}
