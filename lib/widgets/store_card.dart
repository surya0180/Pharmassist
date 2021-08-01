import 'package:flutter/material.dart';
import 'package:pharmassist/screens/store_detail_screen.dart';

class StoreCard extends StatelessWidget {
  final String storeId;
  final String name;
  final String firmId;
  final String establishmentYear;
  final String street;
  final String town;
  final String district;
  final String state;
  final bool isNew;

  StoreCard(
    this.storeId,
    this.name,
    this.firmId,
    this.establishmentYear,
    this.street,
    this.town,
    this.district,
    this.state,
    this.isNew,
  );

  @override
  Widget build(BuildContext context) {
    print(isNew);
    return Container(
      height: 250,
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              StoreDetailScreen.routeName,
              arguments: storeId,
            );
          },
          child: isNew
              ? Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Add Store"),
                      SizedBox(
                        height: 10,
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
