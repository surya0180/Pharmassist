import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmassist/helpers/NavList.dart';
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
  final firestoreInstance = FirebaseFirestore.instance;
  int _selectedPageIndex = 0;
  var _isInit = true;
  var _isLoading = false;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  dynamic _isAdminStatus() {
    final _isAdmin = Provider.of<UserProvider>(context).getIsAdminStatus;
    return _isAdmin;
  }

  @override
  void initState() {
    _selectedPageIndex = 2;
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
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(
                _isAdminStatus() == null
                    ? 'Logging out . .'
                    : _isAdminStatus()
                        ? adminPages[_selectedPageIndex]['title']
                        : userPages[_selectedPageIndex]['title'],
                style: Theme.of(context).textTheme.title,
              ),
              actions: [],
            ),
            body: _isAdminStatus() == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : _isAdminStatus()
                    ? adminPages[_selectedPageIndex]['page']
                    : userPages[_selectedPageIndex]['page'],
            backgroundColor: Theme.of(context).backgroundColor,
            drawer: SideDrawer(),
            bottomNavigationBar: BottomNavBar(
              selectPage: _selectPage,
              selectedPageIndex: _selectedPageIndex,
            ),
          );
  }
}
