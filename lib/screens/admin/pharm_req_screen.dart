import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmassist/providers/NetworkNotifier.dart';
import 'package:pharmassist/widgets/requests/request_item.dart';
import 'package:provider/provider.dart';

class PharmReqScreen extends StatelessWidget {
  final bool isDeleted;
  PharmReqScreen(this.isDeleted);
  final requestType = "pharm";

  @override
  Widget build(BuildContext context) {
    var streamBuilder = FirebaseFirestore.instance
        .collection('pharmacist requests')
        .orderBy('timestamp', descending: true)
        .where('isDeleted', isEqualTo: isDeleted)
        .snapshots();
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: RefreshIndicator(
        onRefresh: Provider.of<NetworkNotifier>(context).setIsConnected,
        child: Provider.of<NetworkNotifier>(context).getIsConnected
            ? StreamBuilder(
                stream: streamBuilder,
                builder: (ctx, pharmSnapShot) {
                  if (pharmSnapShot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final pharmReqs = pharmSnapShot.data.docs;

                  return ListView.builder(
                      itemCount: pharmReqs.length,
                      itemBuilder: (ctx, i) {
                        return RequestItem(
                            pharmReqs[i].data()['createdOn'],
                            pharmReqs[i].data()['about'],
                            pharmReqs[i].data()['request'],
                            pharmReqs[i].data()['userId'],
                            pharmReqs[i].data()['PhotoUrl'],
                            pharmReqs[i].data()['username'],
                            requestType,
                            pharmReqs[i].id,
                            isDeleted);
                      });
                })
            : ListView(
                children: [
                  SizedBox(
                    height: 220,
                  ),
                  Center(
                    child: Text("Something went wrong!  Please try again"),
                  )
                ],
              ),
      ),
    );
  }
}
