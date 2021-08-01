import 'package:flutter/material.dart';
import 'package:pharmassist/helpers/stores.dart';
import 'package:pharmassist/providers/store.dart';
import 'package:pharmassist/providers/user.dart';
import 'package:pharmassist/widgets/store_card.dart';
import 'package:provider/provider.dart';

class StoreScreen extends StatefulWidget {
  static final routeName = "/store-screen";

  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  var _isInit = true;
  var _isLoading = false;
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<StoreProvider>(context, listen: false)
          .getStoreData()
          .then((value) {
        if (value) {
          print("i am in line 52");
          _isInit = false;
          setState(() {
            _isLoading = false;
          });
        } else {
          print("i am else");
          didChangeDependencies();
        }
      });
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var stores = Provider.of<StoreProvider>(context).stores;
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Stores"),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: stores.length,
              itemBuilder: (ctx, i) => StoreCard(
                stores[i].storeId,
                stores[i].name,
                stores[i].firmId,
                stores[i].establishmentYear,
                stores[i].street,
                stores[i].town,
                stores[i].district,
                stores[i].state,
                stores[i].isNew,

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
