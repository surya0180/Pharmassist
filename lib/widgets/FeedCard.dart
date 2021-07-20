import 'package:flutter/material.dart';

class FeedCard extends StatefulWidget {
  const FeedCard({this.randomColor, Key key}) : super(key: key);

  final Color randomColor;

  @override
  _FeedCardState createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {
  bool _liked = false;

  @override
  Widget build(BuildContext context) {
    var device = MediaQuery.of(context).size;
    return Card(
      color: widget.randomColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(device.height*0.02)),
      elevation: 4,
      margin: EdgeInsets.all(device.height*0.027),
      child: GridTile(
        header: Container(
          alignment: Alignment(0, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(device.height*0.02),
              topRight: Radius.circular(device.height*0.02),
            ),
            color: Colors.black26,
          ),
          height: device.height*0.059,
          child: Text(
            'About covaxin supply',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          margin: EdgeInsets.only(top: device.height*0.0001),
        ),
        child: InkWell(
          onTap: () {},
          splashColor: Theme.of(context).splashColor,
          borderRadius: BorderRadius.circular(device.height*0.02),
          child: Container(
            decoration: BoxDecoration(boxShadow: []),
            child: Padding(
              padding:
                  EdgeInsets.only(left: device.height*0.027, right: device.height*0.027, top: device.height*0.0828, bottom: device.height*0.018),
              child: Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type, specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets'),
            ),
          ),
        ),
        footer: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              blurRadius: device.height*0.03,
              offset: Offset(0, -15),
              spreadRadius: 1,
              color: Colors.grey[200],
            )
          ]),
          child: GridTileBar(
            leading: IconButton(
              icon: Icon(
                _liked ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                color: widget.randomColor,
              ),
              onPressed: () {
                setState(() {
                  _liked = !_liked;
                });
              },
              color: Theme.of(context).accentColor,
            ),
            backgroundColor: Colors.black87,
            title: Align(
              child: Text(
                '1.6k',
                textAlign: TextAlign.center,
              ),
              alignment: Alignment(-1.1, 0),
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.edit,
                color: widget.randomColor,
              ),
              onPressed: () {},
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
      ),
    );
  }
}
