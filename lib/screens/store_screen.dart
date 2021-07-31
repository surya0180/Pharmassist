import 'package:flutter/material.dart';
import 'package:pharmassist/helpers/stores.dart';
import 'package:pharmassist/providers/store.dart';
import 'package:pharmassist/widgets/store_card.dart';
import 'package:provider/provider.dart';

class StoreScreen extends StatelessWidget {
  static final routeName = "/store-screen";
  @override
  Widget build(BuildContext context) {
    // s
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Stores"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: stores.length,
        itemBuilder: (ctx, i) => StoreCard(
          stores[i]["name"],
          stores[i]["firm_id"],
          stores[i]["establishment_year"],
          stores[i]["street"],
          stores[i]["town"],
          stores[i]["district"],
          stores[i]["state"],
          stores[i]["isNew"],

          // loadedProducts[i].id,
          // loadedProducts[i].title,
          // loadedProducts[i].imageUrl,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
