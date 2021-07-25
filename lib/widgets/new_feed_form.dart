import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pharmassist/helpers/Colors.dart';
import 'package:pharmassist/providers/comment_provider.dart';
import 'package:pharmassist/providers/feed.dart';
import 'package:pharmassist/providers/feed_provider.dart';
import 'package:provider/provider.dart';

class NewFeedForm extends StatefulWidget {
  static const routeName = "/add-feed";
  @override
  _NewFeedFormState createState() => _NewFeedFormState();
}

class _NewFeedFormState extends State<NewFeedForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  var _isInit = true;

  String _id = '';
  String _title = "";
  String _description = "";
  int _likes = 0;
  Color _color;

  Color _generateRandomColor() {
    var rc = Random();
    return themeColors[rc.nextInt(10)];
  }

  void _submit() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    FocusScope.of(context).unfocus();
    var myid = DateTime.now().toString();
    if (_id == null) {
      Provider.of<FeedProvider>(context, listen: false).addFeed(
        Feed(
          id: myid,
          title: _title,
          content: _description,
          likes: 0,
          color: _generateRandomColor(),
        ),
      );
      Provider.of<CommentProvider>(context, listen: false).addCommentSection(
        myid,
        [],
      );
    } else {
      print(_id);
      print(_title);
      print(_description);
      print(_likes);
      print(_color);
      Provider.of<FeedProvider>(context, listen: false).updateFeed(
        _id,
        Feed(
          id: _id,
          title: _title,
          content: _description,
          likes: _likes,
          color: _color,
        ),
      );
    }
    Navigator.of(context).pop();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      _id = ModalRoute.of(context).settings.arguments as String;
      if (_id != null) {
        final feed =
            Provider.of<FeedProvider>(context, listen: false).findById(_id);
        _title = feed.title;
        _description = feed.content;
        _likes = feed.likes;
        _color = feed.color;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Feed"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _title,
                      decoration: InputDecoration(
                        hintText: 'Title',
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(Icons.account_circle),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 20.0,
                        height: 1.5,
                        color: Colors.black,
                      ),
                      validator: (value) {
                        if (value.trim().length > 28) {
                          return 'Length must be less that or equal to 18';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onSaved: (value) {
                        setState(() {
                          _title = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    // this is where the
                    // input goes

                    TextFormField(
                      initialValue: _description,
                      minLines: 4,
                      maxLines: 6,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(
                        fontSize: 20.0,
                        height: 1.5,
                        color: Colors.black,
                      ),
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(bottom: 100),
                          child: Icon(Icons.description),
                        ),
                        hintText: 'Description',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                      onSaved: (value) {
                        setState(() {
                          _description = value;
                        });
                      },
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: RaisedButton(
                        onPressed: _submit,
                        child: Text("submit"),
                      ),
                    ),
                  ],
                ),
              ),
              // this is where
              // the form field
              // are defined
            ],
          ),
        ),
      ),
    );
  }
}
