import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pharmassist/providers/NetworkNotifier.dart';
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
      Navigator.of(context).pop(true);
      Provider.of<FeedProvider>(context, listen: false)
          .addFeed(
              Feed(
                id: timeStamp.toIso8601String(),
                title: _title,
                content: _description,
                likes: 0,
                color: _generateRandomColor(),
                createdOn: DateFormat.yMd().format(timeStamp),
                createdBy: Provider.of<UserProvider>(context, listen: false)
                    .user
                    .fullname,
                profilePic: Provider.of<UserProvider>(context, listen: false)
                    .user
                    .photoUrl,
              ),
              timeStamp.toIso8601String())
          .then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.black,
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 40),
            duration: const Duration(seconds: 2),
            content: const Text('Added feed sucessfully'),
          ),
        );
        Navigator.of(context).pop(true);
      });
      Provider.of<CommentProvider>(context, listen: false).createCommentSection(
        timeStamp.toIso8601String(),
      );
    } else {
      var timeStamp = DateTime.now();
      Navigator.of(context).pop(true);
      Provider.of<FeedProvider>(context, listen: false)
          .updateFeed(_id, _title, _description, timeStamp)
          .then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.black,
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 40),
            duration: const Duration(seconds: 2),
            content: const Text('Updated feed sucessfully'),
          ),
        );
        Navigator.of(context).pop(true);
      });
    }
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
                content: const Text(
                  'Are you sure you want to leave the form?',
                  style: const TextStyle(fontFamily: 'poppins', fontSize: 16),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: const Text(
                      'No',
                      style:
                          const TextStyle(fontFamily: 'poppins', fontSize: 12),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  FlatButton(
                    child: const Text(
                      'Yes, exit',
                      style:
                          const TextStyle(fontFamily: 'poppins', fontSize: 12),
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
          title: const Text("Add Feed"),
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
                        decoration: const InputDecoration(
                          hintText: 'Title',
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: const Icon(Icons.account_circle),
                          border: const OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20.0)),
                          ),
                        ),
                        style: const TextStyle(
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
                        height: device.height * 0.026,
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
                        style: const TextStyle(
                          fontSize: 20.0,
                          height: 1.5,
                          color: Colors.black,
                        ),
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          prefixIcon: const Padding(
                            padding: const EdgeInsets.only(bottom: 100),
                            child: const Icon(Icons.description),
                          ),
                          hintText: 'Description',
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: const OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20.0)),
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
                        height: device.height * 0.026,
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
                                    content: const Text(
                                      'Are you sure you want to submit this form',
                                      style: const TextStyle(
                                          fontFamily: 'poppins', fontSize: 16),
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: const Text(
                                          'Check once again',
                                          style: const TextStyle(
                                              fontFamily: 'poppins',
                                              fontSize: 12),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop(false);
                                        },
                                      ),
                                      FlatButton(
                                        child: const Text(
                                          'I am good to go',
                                          style: const TextStyle(
                                              fontFamily: 'poppins',
                                              fontSize: 12),
                                        ),
                                        onPressed: () {
                                          FocusScope.of(context).unfocus();
                                          Provider.of<NetworkNotifier>(context,
                                                  listen: false)
                                              .setIsConnected()
                                              .then((value) {
                                            if (Provider.of<NetworkNotifier>(
                                                    context,
                                                    listen: false)
                                                .getIsConnected) {
                                              _submit();
                                            } else {
                                              Navigator.of(context).pop(true);
                                              Navigator.of(context).pop(true);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  backgroundColor: Colors.red,
                                                  content: const Text(
                                                    'Please check your network connection',
                                                  ),
                                                  duration: const Duration(
                                                      seconds: 1,
                                                      milliseconds: 200),
                                                ),
                                              );
                                            }
                                          });
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: const Text("submit"),
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
