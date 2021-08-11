import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmassist/providers/auth/user.dart';
import 'package:pharmassist/widgets/store/store_card.dart';
import 'package:provider/provider.dart';

class StoreScreen extends StatefulWidget {
  static final routeName = "/store-screen";

  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser.uid;
    final _isAdded =
        Provider.of<UserProvider>(context, listen: false).getIsAddedStatus;
    final device = MediaQuery.of(context).size;
    return _isAdded
        ? Scaffold(
            body: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('stores')
                    .doc(uid)
                    .collection('sub Stores')
                    .where('isDeleted', isEqualTo: false)
                    .orderBy('timeStamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final storeDocs = snapshot.data.docs;
                  return GridView.builder(
                    padding: const EdgeInsets.all(10.0),
                    itemCount: storeDocs.length,
                    itemBuilder: (ctx, i) => StoreCard(
                      storeDocs[i].data()['uid'],
                      storeDocs[i].data()['storeId'],
                      storeDocs[i].data()['name'],
                      storeDocs[i].data()['firmId'],
                      storeDocs[i].data()['establishmentYear'],
                      storeDocs[i].data()['street'],
                      storeDocs[i].data()['town'],
                      storeDocs[i].data()['district'],
                      storeDocs[i].data()['state'],
                      storeDocs[i].data()['isNew'],
                      storeDocs[i].data()['timeStamp'],
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                  );
                }),
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.account_box,
                  size: 58,
                  color: Colors.black38,
                ),
                SizedBox(
                  height: device.height * 0.02,
                ),
                Container(
                  width: device.width * 0.6,
                  child: Text(
                    'Please complete your profile to access this page',
                    style: TextStyle(
                      color: Colors.black38,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
