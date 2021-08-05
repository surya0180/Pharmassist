import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pharmassist/providers/user.dart';
import 'package:provider/provider.dart';

class PharmacistRequestForm extends StatefulWidget {
  const PharmacistRequestForm({Key key}) : super(key: key);

  static const routeName = '/pharmacist-form';

  @override
  _PharmacistRequestFormState createState() => _PharmacistRequestFormState();
}

class _PharmacistRequestFormState extends State<PharmacistRequestForm> {
  final _form = GlobalKey<FormState>();

  String _title;
  String _request;

  void _saveForm() {
    _form.currentState.save();
    var uid = FirebaseAuth.instance.currentUser.uid;
    var timeStamp = DateTime.now();
    var createdOn = DateFormat('yyyy-MM-dd hh:mm').format(timeStamp);
    var docName = uid + timeStamp.toIso8601String();
    var userData = Provider.of<UserProvider>(context, listen: false).user;
    FirebaseFirestore.instance
        .collection('pharmacist requests')
        .doc('$docName')
        .set({
      'about': _title,
      'request': _request,
      'timestamp': timeStamp,
      'createdOn': createdOn,
      'userId': userData.uid,
      'username': userData.fullname,
      'PhotoUrl': userData.photoUrl,
    }).then((value) {
      int count = 0;
      Navigator.of(context).popUntil((_) => count++ >= 2);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Request sent sucessfully'),
        ),
      );
    });
    print(_title);
    print(_request);
  }

  @override
  Widget build(BuildContext context) {
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
          title: Text('Pharmacist form'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _form,
            child: ListView(
              children: [
                CircleAvatar(
                  radius: MediaQuery.of(context).size.height * 0.08,
                  child: Icon(
                    Icons.how_to_reg_sharp,
                    size: MediaQuery.of(context).size.height * 0.1,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Text(
                  'Title  :',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.only(left: 12),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: InputBorder.none,
                  ),
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
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Text(
                  'Request details  :',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(),
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.only(left: 12),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value.trim().length == 0) {
                      return 'This field is required';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _request = value;
                    });
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                ElevatedButton(
                  onPressed: () {
                    final isValid = _form.currentState.validate();
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
                                      fontFamily: 'poppins', fontSize: 12),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                              ),
                              FlatButton(
                                child: Text(
                                  'I am good to go',
                                  style: TextStyle(
                                      fontFamily: 'poppins', fontSize: 12),
                                ),
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  _saveForm();
                                },
                              ),
                            ],
                          );
                        });
                  },
                  child: Text(
                    'Send request',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
