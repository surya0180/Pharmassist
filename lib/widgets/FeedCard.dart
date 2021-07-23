import 'package:flutter/material.dart';
import 'package:pharmassist/providers/feed.dart';
import 'package:pharmassist/screens/comments_screen.dart';
import 'package:pharmassist/screens/feed_detail_screeen.dart';
import 'package:provider/provider.dart';

class FeedCard extends StatefulWidget {
  const FeedCard({Key key}) : super(key: key);

  @override
  _FeedCardState createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {
  @override
  Widget build(BuildContext context) {
    final feed = Provider.of<Feed>(context, listen: false);
    var device = MediaQuery.of(context).size;

    return Card(
      color: feed.color,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(device.height * 0.02)),
      elevation: 4,
      margin: EdgeInsets.all(device.height * 0.027),
      child: GridTile(
        header: Container(
          alignment: Alignment(0, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(device.height * 0.02),
              topRight: Radius.circular(device.height * 0.02),
            ),
            color: Colors.black26,
          ),
          height: device.height * 0.059,
          child: Text(
            feed.title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          margin: EdgeInsets.only(top: device.height * 0.0001),
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              FeedDetailScreen.routeName,
              arguments: feed.id,
            );
          },
          splashColor: Theme.of(context).splashColor,
          borderRadius: BorderRadius.circular(device.height * 0.02),
          child: Container(
            decoration: BoxDecoration(boxShadow: []),
            child: Padding(
              padding: EdgeInsets.only(
                  left: device.height * 0.027,
                  right: device.height * 0.027,
                  top: device.height * 0.0828,
                  bottom: device.height * 0.018),
              child: Text(feed.content),
            ),
          ),
        ),
        footer: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              blurRadius: device.height * 0.03,
              offset: Offset(0, -15),
              spreadRadius: 1,
              color: Colors.grey[200],
            )
          ]),
          child: GridTileBar(
            leading: Consumer<Feed>(
              builder: (ctx, feed, _) => IconButton(
                icon: Icon(
                  feed.isLiked ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                  color: feed.color,
                ),
                onPressed: () {
                  feed.isLikedStatus();
                },
                color: Theme.of(context).accentColor,
              ),
            ),
            backgroundColor: Colors.black87,
            title: Align(
              child: Text(
                '${feed.likes}',
                textAlign: TextAlign.center,
              ),
              alignment: Alignment(-1.1, 0),
            ),
            trailing: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.comment,
                    color: feed.color,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(CommentScreen.routeName);
                  },
                  color: Theme.of(context).accentColor,
                ),
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: feed.color,
                  ),
                  onPressed: () {},
                  color: Theme.of(context).accentColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
