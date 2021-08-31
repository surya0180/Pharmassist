import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pharmassist/providers/NetworkNotifier.dart';
import 'package:pharmassist/helpers/NavList.dart';
import 'package:pharmassist/providers/auth/admin-provider.dart';
import 'package:pharmassist/providers/notification-provider.dart';
import 'package:pharmassist/providers/profileEditStatus.dart';
import 'package:pharmassist/providers/auth/user.dart';
import 'package:pharmassist/screens/chat/chat_screen.dart';
import 'package:pharmassist/screens/feeds/feed_detail_screeen.dart';
import 'package:pharmassist/widgets/UI/BottomNavBar.dart';
import 'package:provider/provider.dart';

import '../widgets/UI/SideDrawer.dart';
import 'admin/request_detail_screen.dart';
import '../helpers/string_extension.dart';

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
    fbm.subscribeToTopic("feed");
    FirebaseMessaging.onMessage.listen((message) {
      final route = message.notification.android.tag;
      if (route == "request") {
        return;
      }
      if (route == "chat") {
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
        return;
      }
      if (route == "feed") {
        if (message.notification.bodyLocArgs[5] !=
            FirebaseAuth.instance.currentUser.uid) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 40),
              duration: Duration(seconds: 2),
              content: Text('New feed available'),
            ),
          );
        }
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final route = message.notification.android.tag;
      if (route == "request") {
        Navigator.of(context)
            .pushNamed(RequestDetailScreen.routeName, arguments: {
          'userName': message.notification.title,
          'uid': message.notification.bodyLocArgs[0],
          'createdOn': message.notification.bodyLocArgs[1],
          'title': message.notification.body,
          'detail': message.notification.bodyLocArgs[2],
          'chatData': {
            'username': message.notification.bodyLocArgs[4].toString().capitalize(),
            'uid': message.notification.bodyLocArgs[5],
            'bucketId': message.notification.bodyLocArgs[6],
            'participants': [message.notification.bodyLocArgs[7], message.notification.bodyLocArgs[8]],
            'unreadMessages': int.parse(message.notification.bodyLocArgs[9]),
          },
          'photoUrl': message.notification.bodyLocArgs[3],
        });
        return;
      }
      if (route == "chat") {
        if (message.notification.bodyLocArgs[0] ==
            FirebaseAuth.instance.currentUser.uid) {
          FirebaseFirestore.instance
              .collection('chat')
              .doc(message.notification.bodyLocArgs[0])
              .collection('chatList')
              .doc(message.notification.bodyLocArgs[1])
              .update({'unreadMessages': 0});
        } else {
          FirebaseFirestore.instance
              .collection('chat')
              .doc(message.notification.bodyLocArgs[1])
              .collection('chatList')
              .doc(message.notification.bodyLocArgs[0])
              .update({'unreadMessages': 0});
        }
        Navigator.of(context).pushNamed(ChatScreen.routeName, arguments: {
          'username': message.notification.title,
          'uid': message.notification.bodyLocArgs[3],
          'bucketId': message.notification.bodyLocArgs[2],
          'unreadMessages': message.notification.bodyLocArgs[4],
          'participants': [
            message.notification.bodyLocArgs[0],
            message.notification.bodyLocArgs[1]
          ],
        });
        return;
      }
      if (route == "feed") {
        if (message.notification.bodyLocArgs[5] !=
            FirebaseAuth.instance.currentUser.uid) {
          Navigator.of(context).pushNamed(
            FeedDetailScreen.routeName,
            arguments: {
              'id': message.notification.bodyLocArgs[0],
              'title': message.notification.bodyLocArgs[1],
              'content': message.notification.bodyLocArgs[2],
              'likes': int.parse(message.notification.bodyLocArgs[3]),
              'likedUsers': jsonDecode(message.notification.bodyLocArgs[4]),
            },
          );
        }
      }
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
          Provider.of<AdminProvider>(context, listen: false).getAdminData();
          Provider.of<NetworkNotifier>(context, listen: false)
              .setIsConnected()
              .then((value) {
            Provider.of<NotificationProvider>(context, listen: false)
                .calculateTotalUnreadMessages()
                .then((value) {
              setState(() {
                _isLoading = false;
                _isInit = false;
              });
            });
          });
        } else {
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
