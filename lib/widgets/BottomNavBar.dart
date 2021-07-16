import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final Function selectPage;
  final int selectedPageIndex;

  BottomNavBar({this.selectPage, this.selectedPageIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: selectPage,
      unselectedItemColor: Colors.black,
      selectedItemColor: Colors.blue,
      currentIndex: selectedPageIndex,
      // type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.account_box_rounded),
          title: Text('Profile'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.feed),
          title: Text('Requests'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.mode),
          title: Text('Feed'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          title: Text('Search'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble),
          title: Text('Chat'),
        ),
      ],
    );
  }
}
