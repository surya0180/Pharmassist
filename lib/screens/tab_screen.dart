import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmassist/helpers/NavList.dart';
import 'package:pharmassist/helpers/user_info.dart';
import 'package:pharmassist/providers/user.dart';
import 'package:pharmassist/widgets/BottomNavBar.dart';
import 'package:provider/provider.dart';

import '../widgets/SideDrawer.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key key}) : super(key: key);

  static const routeName = '/tabs-screen';

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Map<String, Object>> _pages;
  final firestoreInstance = FirebaseFirestore.instance;
  int _selectedPageIndex = 0;
  var _isInit = true;
  var _isLoading = false;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    final _isAdmin = Provider.of<UserProvider>(context, listen: false).getIsAdminStatus;
    print(_isAdmin);
    _pages = pages;
    if (!userInfo['isAddedInfo']) {
      _selectedPageIndex = 0;
    } else {
      _selectedPageIndex = 2;
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<UserProvider>(context, listen: false).getData().then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pages[_selectedPageIndex]['title'],
          style: Theme.of(context).textTheme.title,
        ),
        actions: [],
      ),
      body: _isLoading ? Center(child: CircularProgressIndicator(),) : _pages[_selectedPageIndex]['page'],
      backgroundColor: Theme.of(context).backgroundColor,
      drawer: SideDrawer(),
      bottomNavigationBar: BottomNavBar(
        selectPage: _selectPage,
        selectedPageIndex: _selectedPageIndex,
      ),
    );
  }
}
