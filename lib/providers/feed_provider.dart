import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pharmassist/providers/feed.dart';

class FeedProvider with ChangeNotifier {
  List<Feed> _feedItems = [
    Feed(
      id: 'f1',
      title: 'About covaxin supply',
      content:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type, specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets',
      likes: 52,
      isLiked: false,
      color: Colors.purple[100],
    ),
    Feed(
      id: 'f2',
      title: 'About covaxin supply',
      content:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type, specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets',
      likes: 52,
      isLiked: false,
      color: Colors.red[100],
    ),
    Feed(
      id: 'f3',
      title: 'About covaxin supply',
      content:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type, specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets',
      likes: 52,
      isLiked: false,
      color: Colors.orange[100],
    ),
    Feed(
      id: 'f4',
      title: 'About covaxin supply',
      content:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type, specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets',
      likes: 52,
      isLiked: false,
      color: Colors.amber[200],
    ),
    Feed(
      id: 'f5',
      title: 'About covaxin supply',
      content:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type, specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets',
      likes: 52,
      isLiked: false,
      color: Colors.blue[100],
    ),
    Feed(
      id: 'f6',
      title: 'About covaxin supply',
      content:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type, specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets',
      likes: 52,
      isLiked: false,
      color: Colors.green[100],
    ),
  ];

  List<Feed> get feedItems {
    return [..._feedItems];
  }

  Feed findById(String id) {
    return _feedItems.firstWhere(
      (feed) => feed.id == id,
    );
  }
}
