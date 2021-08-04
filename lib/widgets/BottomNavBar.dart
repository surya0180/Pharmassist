import 'package:flutter/material.dart';
import 'package:pharmassist/providers/notification-provider.dart';
import 'package:pharmassist/providers/user.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  final Function selectPage;
  final int selectedPageIndex;

  BottomNavBar({this.selectPage, this.selectedPageIndex});

  @override
  Widget build(BuildContext context) {
    final _isAdmin = Provider.of<UserProvider>(context, listen: false).getIsAdminStatus;
    final _adminUnreadMessages = Provider.of<NotificationProvider>(context, listen: false).getTotalUnreadMessages;
    final _userUnreadMessages = Provider.of<NotificationProvider>(context, listen: false).getTotalUserUnreadMessages;
    final _unreadMessages = _isAdmin ? _adminUnreadMessages : _userUnreadMessages;
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
          icon: _isAdmin ? Stack(
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
                    '5',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ) : Icon(Icons.feed),
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
          icon: _unreadMessages != 0 ? Stack(
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
          ) : Icon(Icons.chat_bubble),
          title: Text(
            'Chat',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ],
    );
  }
}
