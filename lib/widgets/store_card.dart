import 'package:flutter/material.dart';

class StoreCard extends StatelessWidget {
  final String name;
  final String firm_id;
  final String establishment_year;
  final String street;
  final String town;
  final String district;
  final String state;

  StoreCard(
    this.name,
    this.firm_id,
    this.establishment_year,
    this.street,
    this.town,
    this.district,
    this.state,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: GridTile(
        child: GestureDetector(
          onTap: () {},
          child: Card(
            child: Center(child: Text(name)),
          ),
        ),
      ),
    );
  }
}
