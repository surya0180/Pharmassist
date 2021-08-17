import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pharmassist/helpers/NavList.dart';
import 'package:pharmassist/providers/auth/admin-provider.dart';
import 'package:pharmassist/providers/notification-provider.dart';
import 'package:pharmassist/providers/profileEditStatus.dart';
import 'package:pharmassist/providers/auth/user.dart';
import 'package:pharmassist/screens/chat/chat_screen.dart';
import 'package:pharmassist/widgets/UI/BottomNavBar.dart';
import 'package:provider/provider.dart';

import '../widgets/UI/SideDrawer.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key key}) : super(key: key);

  static const routeName = '/tabs-screen';

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final firestoreInstance = FirebaseFirestore.instance;
  var _isInit = true;
  var _isLoading = false;

  int _selectedIndex;
  PageController _pageController;

  void _selectPage(int index) {
    final _isEditing = Provider.of<ProfileEditStatus>(context, listen: false)
        .getIsEditingStatus;
    if (_selectedIndex == 0 && index != 0 && _isEditing) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          content: new Text('Please save your data.'),
          actions: <Widget>[
            new FlatButton(
              onPressed: () => Navigator.pop(context), // Closes the dialog
              child: new Text('Ok'),
            ),
          ],
        ),
      );
    } else {
      setState(() {
        _selectedIndex = index;
        _pageController.animateToPage(index,
            duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
      });
    }
  }

  dynamic _isAdminStatus() {
    final _isAdmin = Provider.of<UserProvider>(context).getIsAdminStatus;
    return _isAdmin;
  }

  @override
  void initState() {
    _selectedIndex = 2;
    _pageController = PageController(initialPage: 2);
    final fbm = FirebaseMessaging.instance;
    fbm.requestPermission();
    FirebaseMessaging.onMessage.listen((message) {
      if (_selectedIndex != 4) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.green,
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 40),
            duration: Duration(seconds: 2),
            content:
                Text('${message.notification.title} messaged you just now'),
          ),
        );
      }
      print("i am in the messaging part1");
      return;
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("i am in the messaging part2");
      Navigator.of(context).pushNamed(ChatScreen.routeName, arguments: {
        'name': message.notification.title,
        'userId': message.notification.bodyLocArgs[0],
        'uidX': message.notification.bodyLocArgs[1],
      });
      print(message);
      return;
    });
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
          Provider.of<AdminProvider>(context, listen: false)
              .getAdminData()
              .then((value) {
            print('I am here lol');
            FirebaseFirestore.instance
                .collection('Chat')
                .doc(FirebaseAuth.instance.currentUser.uid)
                .update({
              "uidX": Provider.of<AdminProvider>(context, listen: false)
                  .getAdminUid,
            });
          });
          Provider.of<NotificationProvider>(context, listen: false)
              .calculateTotalUnreadMessages()
              .then((value) {
            setState(() {
              _isLoading = false;
            });
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
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _isEditingStatus =
        Provider.of<ProfileEditStatus>(context).getIsEditingStatus;
    print(_isEditingStatus);
    print('Above is the editing status');
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : WillPopScope(
            onWillPop: _selectedIndex == 0 && _isEditingStatus
                ? () async {
                    final value = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        content: new Text('Please save your data.'),
                        actions: <Widget>[
                          new FlatButton(
                            onPressed: () =>
                                Navigator.pop(context), // Closes the dialog
                            child: new Text('Ok'),
                          ),
                        ],
                      ),
                    );

                    return value == true;
                  }
                : null,
            child: Scaffold(
              appBar: AppBar(
                elevation: _selectedIndex == 1 ? 0 : 5,
                title: Text(
                  _isAdminStatus() == null
                      ? 'Logging out . .'
                      : _isAdminStatus()
                          ? adminPagesTitles[_selectedIndex]
                          : userPagesTitles[_selectedIndex],
                  style: Theme.of(context).textTheme.title,
                ),
                actions: [],
              ),
              body: _isAdminStatus() == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : SizedBox.expand(
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() => _selectedIndex = index);
                        },
                        children: _isAdminStatus() ? adminPages : userPages,
                      ),
                    ),
              backgroundColor: Theme.of(context).backgroundColor,
              drawer: SideDrawer(),
              bottomNavigationBar: BottomNavBar(
                selectPage: _selectPage,
                selectedPageIndex: _selectedIndex,
              ),
            ),
          );
  }
}
