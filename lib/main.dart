import 'package:flutter/material.dart';

import 'widgets/SideDrawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
  List<Map<String, String>> _pages;

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
        'page': '',
        'title': 'Profile',
      },
      {
        'page': '',
        'title': 'Requests',
      },
      {
        'page': '',
        'title': 'Feed',
      },
      {
        'page': '',
        'title': 'Search',
      },
      {
        'page': '',
        'title': 'Chat',
      },
    ];
    _selectedPageIndex = 2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(_pages[_selectedPageIndex]['title']);
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      drawer: SideDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.blue,
        currentIndex: _selectedPageIndex,
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
      ),
    );
  }
}