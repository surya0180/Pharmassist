import 'package:flutter/material.dart';
import 'package:pharmassist/screens/chat_screen.dart';
import 'package:pharmassist/screens/feed_screen.dart';
import 'package:pharmassist/screens/profile_screen.dart';
import 'package:pharmassist/screens/request_screen.dart';
import 'package:pharmassist/screens/search_screen.dart';
import 'package:pharmassist/widgets/BottomNavBar.dart';

import 'widgets/SideDrawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pharmassist',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Pharmassist'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, Object>> _pages;

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    _pages = [
      {
        'page': ProfileScreen(),
        'title': 'Profile',
      },
      {
        'page': RequestScreen(),
        'title': 'Requests',
      },
      {
        'page': FeedScreen(),
        'title': 'Feed',
      },
      {
        'page': SearchScreen(),
        'title': 'Search',
      },
      {
        'page': ChatScreen(),
        'title': 'Chat',
      },
    ];
    _selectedPageIndex = 2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      body: _pages[_selectedPageIndex]['page'],
      drawer: SideDrawer(),
      bottomNavigationBar: BottomNavBar(
        selectPage: _selectPage,
        selectedPageIndex: _selectedPageIndex,
      ),
      floatingActionButton: _pages[_selectedPageIndex]['title'] == 'Feed'
          ? FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => null,
            )
          : null,
    );
  }
}
