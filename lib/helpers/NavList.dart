import 'package:pharmassist/screens/admin/admin_requests_screen.dart';
import 'package:pharmassist/screens/chat/chat_list_screen.dart';
import 'package:pharmassist/screens/feeds/feed_screen.dart';
import 'package:pharmassist/screens/tabs/profile_screen.dart';
import 'package:pharmassist/screens/tabs/request_screen.dart';
import 'package:pharmassist/screens/tabs/search_screen.dart';

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
