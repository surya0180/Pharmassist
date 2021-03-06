import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmassist/providers/NetworkNotifier.dart';
import 'package:pharmassist/widgets/search/NoResultsFound.dart';
import 'package:pharmassist/widgets/search/SearchBar.dart';
import 'package:pharmassist/widgets/search/StartSearching.dart';
import 'package:pharmassist/widgets/search/StoreSearchResults.dart';
import 'package:pharmassist/widgets/search/UserSearchResult.dart';
import 'package:provider/provider.dart';
import '../../helpers/string_extension.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _value, _category, _filter;

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<NetworkNotifier>(context, listen: false).setIsConnected();
    super.initState();
  }

  void _setQuery(String value, String category, String filter) {
    setState(() {
      _value = value;
      _category = category;
      _filter = filter;
    });
  }

  void _setCategory(String category) {
    setState(() {
      _category = category;
    });
  }

  void _setFilter(String filter) {
    setState(() {
      _filter = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: Provider.of<NetworkNotifier>(context).setIsConnected,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).canvasColor,
          bottom: PreferredSize(
            child: SearchBar(_setQuery, _setCategory, _setFilter),
            preferredSize:const Size.fromHeight(kMinInteractiveDimensionCupertino),
          ),
        ),
        body: Provider.of<NetworkNotifier>(context).getIsConnected
            ? _value == null
                ? StartSearching(_category)
                : StreamBuilder(
                    stream: _category == null ||
                            _category == 'noFilter' ||
                            _category == 'pharms'
                        ? FirebaseFirestore.instance
                            .collection('users')
                            .orderBy('fullName')
                            .where('isAdded', isEqualTo: true)
                            .where('isAdmin', isEqualTo: false)
                            .startAt([_value.toLowerCase()]).endAt(
                            [
                              _value == null
                                  ? '' + '\uf8ff'
                                  : _value.toLowerCase() + '\uf8ff'
                            ],
                          ).snapshots()
                        : FirebaseFirestore.instance
                            .collection('stores label')
                            .where('isDeleted', isEqualTo: false)
                            .orderBy('name')
                            .startAt([_value.toLowerCase()]).endAt(
                            [
                              _value == null
                                  ? '' + '\uf8ff'
                                  : _value.toLowerCase() + '\uf8ff'
                            ],
                          ).snapshots(),
                    builder: (ctx, snapShot) {
                      if (snapShot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child:const CircularProgressIndicator(),
                        );
                      }
                      final docs = snapShot.data.docs;
                      return docs.length == 0
                          ? NoResultsFound()
                          : ListView.builder(
                              itemCount: docs.length,
                              itemBuilder: (ctx, index) {
                                return _category == null ||
                                        _category == 'noFilter' ||
                                        _category == 'pharms'
                                    ? UserSearchResult(
                                        fullname: docs[index]['fullName']
                                            .toString()
                                            .capitalize(),
                                        profilePic: docs[index]['PhotoUrl'],
                                        registerationNumber: docs[index]
                                            ['registrationNo'],
                                        district: docs[index]['district'],
                                        state: docs[index]['state'],
                                        renewalDate: docs[index]['renewalDate'],
                                        street: docs[index]['street'],
                                        town: docs[index]['town'],
                                        uid: docs[index]['uid'],
                                      )
                                    : StoreSearchResult(
                                        name: docs[index]['name']
                                            .toString()
                                            .capitalize(),
                                        storeId: docs[index]['storeId'],
                                        district: docs[index]['district']
                                            .toString()
                                            .capitalize(),
                                        state: docs[index]['state']
                                            .toString()
                                            .capitalize(),
                                        street: docs[index]['street']
                                            .toString()
                                            .capitalize(),
                                        town: docs[index]['town']
                                            .toString()
                                            .capitalize(),
                                        establishmentYear: docs[index]
                                            ['establishmentYear'],
                                        firmId: docs[index]['firmId'],
                                        timestamp: docs[index]['timeStamp'],
                                        uid: docs[index]['uid'],
                                      );
                              },
                            );
                    },
                  )
            : ListView(
                children: [
                  const SizedBox(
                    height: 220,
                  ),
                  const Center(
                    child: Text("Something went wrong!  Please try again"),
                  )
                ],
              ),
      ),
    );
  }
}
