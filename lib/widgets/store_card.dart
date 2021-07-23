import 'package:flutter/material.dart';
import 'package:pharmassist/screens/store_detail_screen.dart';

class StoreCard extends StatelessWidget {
  final String name;
  final String firm_id;
  final String establishment_year;
  final String street;
  final String town;
  final String district;
  final String state;
  final bool isNew;

  StoreCard(
    this.name,
    this.firm_id,
    this.establishment_year,
    this.street,
    this.town,
    this.district,
    this.state,
    this.isNew,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              StoreDetailScreen.routeName,
              arguments: firm_id,
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
