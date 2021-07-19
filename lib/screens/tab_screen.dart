import 'package:flutter/material.dart';
import 'package:pharmassist/helpers/NavList.dart';
import 'package:pharmassist/widgets/BottomNavBar.dart';
import 'package:pharmassist/widgets/MyDropdown.dart';

import '../widgets/SideDrawer.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key key}) : super(key: key);

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
    _selectedPageIndex = 2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pages[_selectedPageIndex]['title'],
          style: Theme.of(context).textTheme.title,
        ),
        actions: [MyDropDown()],
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
