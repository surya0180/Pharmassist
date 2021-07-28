import 'package:pharmassist/screens/admin_requests_screen.dart';
import 'package:pharmassist/screens/chat_list_screen.dart';
import 'package:pharmassist/screens/feed_screen.dart';
import 'package:pharmassist/screens/profile_screen.dart';
import 'package:pharmassist/screens/request_screen.dart';
import 'package:pharmassist/screens/search_screen.dart';

final userPages = [
    {
      'page': ProfilePage(),
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
      'page': ChatListScreen(),
      'title': 'Chat',
    },
  ];

  final adminPages = [
    {
      'page': ProfilePage(),
      'title': 'Profile',
    },
    {
      'page': AdminRequestScreen(),
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
      'page': ChatListScreen(),
      'title': 'Chat',
    },
  ];
