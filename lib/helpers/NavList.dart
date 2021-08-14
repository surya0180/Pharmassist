import 'package:pharmassist/screens/admin/admin_requests_screen.dart';
import 'package:pharmassist/screens/chat/chat_list_screen.dart';
import 'package:pharmassist/screens/feeds/feed_screen.dart';
import 'package:pharmassist/screens/stores/store_screen.dart';
import 'package:pharmassist/screens/tabs/profile_screen.dart';
import 'package:pharmassist/screens/tabs/request_screen.dart';
import 'package:pharmassist/screens/tabs/search_screen.dart';

final userPages = [
  ProfilePage(),
  StoreScreen(),
  FeedScreen(),
  RequestScreen(),
  ChatListScreen(),
];

final userPagesTitles = ['Profile', 'Stores', 'Feed', 'Request', 'Chat'];

final adminPages = [
  ProfilePage(),
  AdminRequestScreen(),
  FeedScreen(),
  SearchScreen(),
  ChatListScreen(),
];

final adminPagesTitles = ['Profile', 'Request', 'Feed', 'Search', 'Chat'];
