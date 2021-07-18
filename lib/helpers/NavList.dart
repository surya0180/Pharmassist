import 'package:pharmassist/screens/chat_screen.dart';
import 'package:pharmassist/screens/feed_screen.dart';
import 'package:pharmassist/screens/profile_screen.dart';
import 'package:pharmassist/screens/request_screen.dart';
import 'package:pharmassist/screens/search_screen.dart';

final pages = [
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