import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmassist/forms/getting_started.dart';
import 'package:pharmassist/helpers/NavList.dart';
import 'package:pharmassist/helpers/user_info.dart';
import 'package:pharmassist/widgets/BottomNavBar.dart';

import '../widgets/SideDrawer.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key key}) : super(key: key);

  static const routeName = '/tabs-screen';

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Map<String, Object>> _pages;

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    _pages = pages;
    print(!userInfo['isAddedInfo']);
    if (!userInfo['isAddedInfo']) {
      _selectedPageIndex = 0;
    } else {
      _selectedPageIndex = 2;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pages[_selectedPageIndex]['title'],
          style: Theme.of(context).textTheme.title,
        ),
        actions: [],
      ),
      body: _pages[_selectedPageIndex]['page'],
      backgroundColor: Theme.of(context).backgroundColor,
      drawer: SideDrawer(),
      bottomNavigationBar: BottomNavBar(
        selectPage: _selectPage,
        selectedPageIndex: _selectedPageIndex,
      ),
    );
  }
}
