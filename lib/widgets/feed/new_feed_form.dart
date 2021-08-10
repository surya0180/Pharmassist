import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pharmassist/helpers/theme/Colors.dart';
import 'package:pharmassist/providers/comments/comment_provider.dart';
import 'package:pharmassist/providers/feed/feed.dart';
import 'package:pharmassist/providers/feed/feed_provider.dart';
import 'package:pharmassist/providers/auth/user.dart';
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

  Color _generateRandomColor() {
    var rc = Random();
    return themeColors[rc.nextInt(10)];
  }

  void _submit() {
    _formKey.currentState.save();
    var timeStamp = DateTime.now();
    if (_id == '') {
      Provider.of<FeedProvider>(context, listen: false).addFeed(
          Feed(
            id: timeStamp.toIso8601String(),
            title: _title,
            content: _description,
            likes: 0,
            color: _generateRandomColor(),
            createdOn: DateFormat.yMd().format(timeStamp),
            createdBy:
                Provider.of<UserProvider>(context, listen: false).user.fullname,
            profilePic:
                Provider.of<UserProvider>(context, listen: false).user.photoUrl,
          ),
          timeStamp.toIso8601String());
      Provider.of<CommentProvider>(context, listen: false).createCommentSection(
        timeStamp.toIso8601String(),
      );
    } else {
      var timeStamp = DateTime.now();
      Provider.of<FeedProvider>(context, listen: false)
          .updateFeed(_id, _title, _description, timeStamp);
    }
    print('hey there');
    int count = 0;
    Navigator.of(context).popUntil((_) => count++ >= 2);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added feed sucessfully'),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      var routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      if (routeArgs != null) {
        _id = routeArgs['id'];
        _title = routeArgs['title'];
        _description = routeArgs['content'];
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(
                  'Are you sure you want to leave the form?',
                  style: TextStyle(fontFamily: 'poppins', fontSize: 16),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      'No',
                      style: TextStyle(fontFamily: 'poppins', fontSize: 12),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  FlatButton(
                    child: Text(
                      'Yes, exit',
                      style: TextStyle(fontFamily: 'poppins', fontSize: 12),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              );
            });

        return value == true;
      },
      child: Scaffold(
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
                        autocorrect: false,
                        textCapitalization: TextCapitalization.sentences,
                        enableSuggestions: true,
                        initialValue: _title,
                        decoration: InputDecoration(
                          hintText: 'Title',
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(Icons.account_circle),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 20.0,
                          height: 1.5,
                          color: Colors.black,
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value.trim().length == 0) {
                            return 'This field is required';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            _title = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: device.height*0.026,
                      ),

                      // this is where the
                      // input goes

                      TextFormField(
                        autocorrect: false,
                        textCapitalization: TextCapitalization.sentences,
                        enableSuggestions: true,
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                        ),
                        validator: (value) {
                          if (value.trim().length == 0) {
                            return 'This field is required';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            _description = value;
                          });
                        },
                      ),

                      SizedBox(
                        height: device.height*0.026,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: RaisedButton(
                          onPressed: () {
                            final isValid = _formKey.currentState.validate();
                            if (!isValid) {
                              return;
                            }
                            showDialog<bool>(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text(
                                      'Are you sure you want to submit this form',
                                      style: TextStyle(
                                          fontFamily: 'poppins', fontSize: 16),
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text(
                                          'Check once again',
                                          style: TextStyle(
                                              fontFamily: 'poppins',
                                              fontSize: 12),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop(false);
                                        },
                                      ),
                                      FlatButton(
                                        child: Text(
                                          'I am good to go',
                                          style: TextStyle(
                                              fontFamily: 'poppins',
                                              fontSize: 12),
                                        ),
                                        onPressed: () {
                                          FocusScope.of(context).unfocus();
                                          _submit();
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
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
      ),
    );
  }
}
