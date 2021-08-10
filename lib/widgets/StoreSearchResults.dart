import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmassist/screens/store_detail_screen.dart';

class StoreSearchResult extends StatelessWidget {
  const StoreSearchResult({
    this.name,
    this.storeId,
    this.district,
    this.establishmentYear,
    this.firmId,
    this.state,
    this.street,
    this.timestamp,
    this.town,
    this.uid,
    Key key,
  }) : super(key: key);

  final String name;
  final String firmId;
  final String establishmentYear;
  final String street;
  final String town;
  final String district;
  final String state;
  final String storeId;
  final String uid;
  final Timestamp timestamp;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.black26),
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(StoreDetailScreen.routeName, arguments: {
            'name': name,
            'firmId': firmId,
            'establishmentYear': establishmentYear,
            'street': street,
            'town': town,
            'district': district,
            'state': state,
            'storeId': storeId,
            'uid': uid,
            'timestamp': timestamp,
            'isNew': false,
          });
        },
        splashColor: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          height: 73,
          padding: EdgeInsets.only(left: 14, right: 10, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: Theme.of(context).textTheme.title,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.008,
                      ),
                      Text(
                        'Establishment-year:  $establishmentYear',
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
