import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final Function selectPage;
  final int selectedPageIndex;

  BottomNavBar({this.selectPage, this.selectedPageIndex});

  @override
  Widget build(BuildContext context) {
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
          icon: Icon(Icons.feed),
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
          icon: Icon(Icons.chat_bubble),
          title: Text(
            'Chat',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ],
    );
  }
}
