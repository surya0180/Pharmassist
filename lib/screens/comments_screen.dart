import 'package:flutter/material.dart';
import 'package:pharmassist/widgets/CommentHolder.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({Key key}) : super(key: key);

  static const routeName = '/comments-screen';

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Comments',
          style: Theme.of(context).textTheme.title,
        ),
      ),
      body: Column(
        children: [
          Container(
            // height: 60,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 1,
                  color: Colors.black12,
                  offset: Offset(2, 3),
                  spreadRadius: 1,
                ),
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: ListTile(
              title: TextField(
                maxLines: 2,
                controller: null,
                decoration: InputDecoration(
                  labelText: 'Comment here',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.send,
                  color: Colors.black,
                ),
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(0),
              itemBuilder: (ctx, index) => CommentHolder(),
              itemCount: 3,
            ),
          ),
        ],
      ),
    );
  }
}
