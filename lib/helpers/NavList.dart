import 'package:pharmassist/screens/admin_requests_screen.dart';
import 'package:pharmassist/screens/chat_list_screen.dart';
import 'package:pharmassist/screens/feed_screen.dart';
import 'package:pharmassist/screens/profile_screen.dart';
import 'package:pharmassist/screens/request_screen.dart';
import 'package:pharmassist/screens/search_screen.dart';

final userPages = [
  ProfilePage(),
  RequestScreen(),
  FeedScreen(),
  SearchScreen(),
  ChatListScreen(),
];

final userPagesTitles = ['Profile', 'Request', 'Feed', 'Search', 'Chat'];

final adminPages = [
  ProfilePage(),
  AdminRequestScreen(),
  FeedScreen(),
  SearchScreen(),
  ChatListScreen(),
];

final adminPagesTitles = ['Profile', 'Request', 'Feed', 'Search', 'Chat'];
