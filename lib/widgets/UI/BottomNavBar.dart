import 'package:flutter/material.dart';
import 'package:pharmassist/providers/auth/admin-provider.dart';
import 'package:pharmassist/providers/notification-provider.dart';
import 'package:pharmassist/providers/auth/user.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  final Function selectPage;
  final int selectedPageIndex;

  BottomNavBar({this.selectPage, this.selectedPageIndex});

  @override
  Widget build(BuildContext context) {
    final count = Provider.of<AdminProvider>(context).requestCount;
    final _isAdmin =
        Provider.of<UserProvider>(context, listen: false).getIsAdminStatus;
    final _adminUnreadMessages =
        Provider.of<NotificationProvider>(context, listen: false)
            .getTotalUnreadMessages;
    final _userUnreadMessages =
        Provider.of<NotificationProvider>(context, listen: false)
            .getTotalUserUnreadMessages;
    final _unreadMessages = _isAdmin != null
        ? _isAdmin
            ? _adminUnreadMessages
            : _userUnreadMessages
        : 0;
    return BottomNavigationBar(
      onTap: selectPage,
      elevation: 10,
      currentIndex: selectedPageIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.account_box_rounded),
          title: Text(
            'Profile',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        BottomNavigationBarItem(
          icon: _isAdmin == null
              ? Icon(Icons.feed)
              : _isAdmin
                  ? count != 0
                      ? Stack(
                          children: <Widget>[
                            Icon(Icons.feed),
                            Positioned(
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 12,
                                  minHeight: 12,
                                ),
                                child: Text(
                                  '$count',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ],
                        )
                      : Icon(Icons.feed)
                  : Icon(Icons.feed),
          title: Text(
            'Requests',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.mode),
          title: Text(
            'Feed',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          title: Text(
            'Search',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        BottomNavigationBarItem(
          icon: _unreadMessages == null
              ? Icon(Icons.chat_bubble)
              : _unreadMessages != 0
                  ? Stack(
                      children: <Widget>[
                        Icon(Icons.chat_bubble),
                        Positioned(
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 12,
                              minHeight: 12,
                            ),
                            child: Text(
                              '$_unreadMessages',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    )
                  : Icon(Icons.chat_bubble),
          title: Text(
            'Chat',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ],
    );
  }
}
