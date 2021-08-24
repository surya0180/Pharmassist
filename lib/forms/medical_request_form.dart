import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pharmassist/providers/NetworkNotifier.dart';
import 'package:pharmassist/providers/auth/admin-provider.dart';
import 'package:pharmassist/providers/auth/user.dart';
import 'package:provider/provider.dart';

class MedicalRequestForm extends StatefulWidget {
  const MedicalRequestForm({Key key}) : super(key: key);

  static const routeName = '/medical-form';

  @override
  _MedicalRequestFormState createState() => _MedicalRequestFormState();
}

class _MedicalRequestFormState extends State<MedicalRequestForm> {
  final _form = GlobalKey<FormState>();

  String _title;
  String _request;

  void _saveForm() async {
    var admidId =
        Provider.of<AdminProvider>(context, listen: false).getAdminUid;
    Navigator.of(context).pop();
    final adminData =
        await FirebaseFirestore.instance.collection('users').doc(admidId).get();
    Provider.of<NetworkNotifier>(context, listen: false)
        .setIsConnected()
        .then((value) {
      if (Provider.of<NetworkNotifier>(context, listen: false).getIsConnected) {
        _form.currentState.save();

        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 40),
            duration: Duration(seconds: 2),
            content: Text('Request sent sucessfully'),
          ),
        );
        var uid = FirebaseAuth.instance.currentUser.uid;
        var timeStamp = DateTime.now();
        var createdOn = DateFormat('yyyy-MM-dd hh:mm').format(timeStamp);
        var docName = uid + timeStamp.toIso8601String();
        var userData = Provider.of<UserProvider>(context, listen: false).user;
        FirebaseFirestore.instance
            .collection('medical requests')
            .doc('$docName')
            .set({
          'about': _title,
          'request': _request,
          'timestamp': timeStamp,
          'createdOn': createdOn,
          'userId': userData.uid,
          'username': userData.fullname,
          'PhotoUrl': userData.photoUrl,
          'isDeleted': false,
          'token': adminData.data()['deviceToken'],
        }).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.black,
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 40),
              duration: Duration(seconds: 1),
              content: const Text(
                'Request Sent sucessfully',
              ),
            ),
          );
        });

        final _count =
            Provider.of<AdminProvider>(context, listen: false).getAdminReq;
        Provider.of<AdminProvider>(context, listen: false)
            .updateRequests(_count + 1);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Please check your network connection',
            ),
            duration: Duration(seconds: 1, milliseconds: 200),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: const Text(
                  'Are you sure you want to leave the form?',
                  style: TextStyle(fontFamily: 'poppins', fontSize: 16),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: const Text(
                      'No',
                      style: TextStyle(fontFamily: 'poppins', fontSize: 12),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  FlatButton(
                    child: const Text(
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
          title: const Text('Medical form'),
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
                    Icons.medical_services,
                    size: MediaQuery.of(context).size.height * 0.1,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                const Text(
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
                  autocorrect: false,
                  textCapitalization: TextCapitalization.sentences,
                  enableSuggestions: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: const EdgeInsets.only(left: 12),
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
                const Text(
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
                  autocorrect: true,
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.multiline,
                  enableSuggestions: true,
                  maxLines: 8,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(),
                    border: OutlineInputBorder(),
                    contentPadding: const EdgeInsets.only(left: 12, top: 25),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: InputBorder.none,
                  ),
                  textInputAction: TextInputAction.none,
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
                            content: const Text(
                              'Are you sure you want to submit this form',
                              style: TextStyle(
                                  fontFamily: 'poppins', fontSize: 16),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: const Text(
                                  'Check once again',
                                  style: TextStyle(
                                      fontFamily: 'poppins', fontSize: 12),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                              ),
                              FlatButton(
                                child: const Text(
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
                  child: const Text(
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
