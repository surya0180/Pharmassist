import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:pharmassist/providers/NetworkNotifier.dart';
import 'package:pharmassist/helpers/states.dart';
import 'package:pharmassist/providers/auth/user.dart';
import 'package:pharmassist/providers/store.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';
import '../../helpers/string_extension.dart';

class StoreDetailScreen extends StatefulWidget {
  static final routeName = "/add-store-page";
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<StoreDetailScreen>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  bool _init = true;
  final FocusNode myFocusNode = FocusNode();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  bool _isNew = true;
  String _name = "";
  String _firmId = "";
  String _establishmentYear = "";
  String _street = '';
  String _town = '';
  String _district = '';
  String _state = '';
  String _storeId = '';
  String _uid = '';
  Timestamp _timestamp;
  TextEditingController dateinput = TextEditingController();
  String dropdownValue;
  bool isAdmin = false;
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<NetworkNotifier>(context, listen: false).setIsConnected();
    dateinput.text = "";
    dropdownValue = "maharashtra";
    isAdmin =
        Provider.of<UserProvider>(context, listen: false).getIsAdminStatus;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_init) {
      var routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
      if (routeArgs != null) {
        _name = routeArgs['name'];
        _firmId = routeArgs['firmId'];
        _establishmentYear = routeArgs['establishmentYear'];
        _street = routeArgs['street'];
        _town = routeArgs['town'];
        _district = routeArgs['district'];
        _state = routeArgs['state'];
        _isNew = routeArgs['isNew'];
        _storeId = routeArgs['storeId'];
        _uid = routeArgs['uid'];
        _timestamp = routeArgs['timestamp'];
      }
      dateinput.text = _establishmentYear;
      if (_state != "") {
        dropdownValue = _state.toLowerCase().toString();
      }
      if (_isNew) {
        _status = false;
      }

      _init = false;
    }

    super.didChangeDependencies();
  }

  _onSubmit() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    // Navigator.of(context).pop();
    Provider.of<NetworkNotifier>(context, listen: false)
        .setIsConnected()
        .then((value) {
      if (Provider.of<NetworkNotifier>(context, listen: false).getIsConnected) {
        _formKey.currentState.save();
        if (_isNew == true) {
          Provider.of<StoreProvider>(context, listen: false)
              .createStore(
            Store(
              name: _name,
              firmId: _firmId,
              establishmentYear: _establishmentYear,
              street: _street,
              town: _town,
              district: _district,
              state: _state,
              isNew: _isNew,
              timestamp: Timestamp.now(),
            ),
          )
              .then((value) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.black,
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 40),
                duration: Duration(seconds: 1),
                content: const Text(
                  'Created Store sucessfully',
                ),
              ),
            );
          });
        } else {
          Provider.of<StoreProvider>(context, listen: false)
              .updateStore(
            Store(
              name: _name,
              firmId: _firmId,
              establishmentYear: _establishmentYear,
              street: _street,
              town: _town,
              district: _district,
              state: _state,
              isNew: _isNew,
              timestamp: _timestamp,
              uid: _uid,
              storeId: _storeId,
            ),
          )
              .then((value) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.black,
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 40),
                duration: Duration(seconds: 2),
                content: const Text(
                  'Updated Store sucessfully',
                ),
              ),
            );
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
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
    if (_uid != FirebaseAuth.instance.currentUser.uid) {
      return Scaffold(
        appBar: AppBar(
          title: Text(_name),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(_uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final userDocs = snapshot.data;
            final userName = userDocs['fullName'];
            return ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    new Container(
                      color: Color(0xffFFFFFF),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 25.0),
                        child: Form(
                          key: _formKey,
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          const Text(
                                            'Store Information',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              isAdmin
                                                  ? _getChatIcon()
                                                  : new Container(),
                                              SizedBox(
                                                width: 5,
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          const Text(
                                            'Store Name',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: new TextFormField(
                                          initialValue:
                                              _name.toString().capitalize(),
                                          enabled: !_status,
                                          autofocus: !_status,
                                        ),
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          const Text(
                                            'Store Owner Name',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: new TextFormField(
                                          readOnly: true,
                                          initialValue:
                                              userName.toString().capitalize(),
                                        ),
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          const Text(
                                            'Firm Id',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: new TextFormField(
                                          initialValue: _firmId,
                                          enabled: !_status,
                                        ),
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          const Text(
                                            "Establishment Year",
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: new TextFormField(
                                          readOnly: true,
                                          controller: dateinput,
                                          enabled: !_status,
                                        ),
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          child: const Text(
                                            'Street',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        flex: 2,
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: const Text(
                                            'Town',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        flex: 2,
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: new TextFormField(
                                            initialValue:
                                                _street.toString().capitalize(),
                                            enabled: !_status,
                                          ),
                                        ),
                                        flex: 2,
                                      ),
                                      Flexible(
                                        child: new TextFormField(
                                          initialValue:
                                              _town.toString().capitalize(),
                                          enabled: !_status,
                                        ),
                                        flex: 2,
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          child: const Text(
                                            'District',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        flex: 2,
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: const Text(
                                            'State',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        flex: 2,
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: new TextFormField(
                                            initialValue: _district
                                                .toString()
                                                .capitalize(),
                                            enabled: !_status,
                                          ),
                                        ),
                                        flex: 2,
                                      ),
                                      Flexible(
                                        child: IgnorePointer(
                                          ignoring: _status,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                DropdownButtonFormField<String>(
                                                  onSaved: (value) {
                                                    setState(() {
                                                      _state = value;
                                                    });
                                                  },
                                                  isExpanded: true,
                                                  value: dropdownValue,
                                                  onChanged: (String newValue) {
                                                    setState(() {
                                                      dropdownValue = newValue;
                                                    });
                                                  },
                                                  items: statesItems,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        flex: 2,
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            );
          },
        ),
      );
    }
    return WillPopScope(
      onWillPop: () async {
        if (_status) {
          return true;
        }
        final value = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: const Text(
                  'Are you sure you want to discard the changes?',
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
      child: new Scaffold(
          appBar: AppBar(
            title: _name == "" ? Text(_name) : Text("New Store"),
          ),
          body: new Container(
            color: Colors.white,
            child: new ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    new Container(
                      color: Color(0xffFFFFFF),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 25.0),
                        child: Form(
                          key: _formKey,
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          const Text(
                                            'Store Information',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              _status
                                                  ? _uid !=
                                                          FirebaseAuth.instance
                                                              .currentUser.uid
                                                      ? new Container()
                                                      : _getEditIcon()
                                                  : new Container(),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              !_isNew
                                                  ? _status
                                                      ? _uid !=
                                                              FirebaseAuth
                                                                  .instance
                                                                  .currentUser
                                                                  .uid
                                                          ? new Container()
                                                          : _getDeleteIcon()
                                                      : new Container()
                                                  : new Container(),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          const Text(
                                            'Store Name',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: new TextFormField(
                                          onSaved: (value) {
                                            setState(() {
                                              _name = value;
                                            });
                                          },
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          validator: (value) {
                                            if (value.trim().length == 0) {
                                              return 'This field is required';
                                            }
                                            if (!isAlphanumeric(
                                                value.replaceAll(' ', ''))) {
                                              return 'Please Enter Valid Value';
                                            }
                                            return null;
                                          },
                                          initialValue:
                                              _name.toString().capitalize(),
                                          decoration: const InputDecoration(
                                            hintText: "Enter Store Name",
                                          ),
                                          enabled: !_status,
                                          autofocus: !_status,
                                        ),
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          const Text(
                                            'Firm Id',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: new TextFormField(
                                          onSaved: (value) {
                                            setState(() {
                                              _firmId = value;
                                            });
                                          },
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          validator: (value) {
                                            if (value.trim().length == 0) {
                                              return 'This field is required';
                                            }
                                            if (!isAlphanumeric(
                                                value.replaceAll(' ', ''))) {
                                              return 'Please Enter Valid Value';
                                            }
                                            return null;
                                          },
                                          initialValue: _firmId,
                                          decoration: const InputDecoration(
                                              hintText: "Enter Firm Id"),
                                          enabled: !_status,
                                        ),
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          const Text(
                                            "Establishment Year",
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: new TextFormField(
                                          onSaved: (value) {
                                            setState(() {
                                              _establishmentYear = value;
                                            });
                                          },
                                          readOnly: true,
                                          onTap: () async {
                                            DateTime pickedDate =
                                                await showDatePicker(
                                                    context:
                                                        context, //context of current state
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(
                                                        1980), //DateTime.now() - not to allow to choose before today.
                                                    lastDate: DateTime(2101));

                                            if (pickedDate != null) {
                                              String formattedDate =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(pickedDate);
                                              setState(() {
                                                _establishmentYear =
                                                    formattedDate;
                                                dateinput.text = formattedDate;
                                              });
                                            } else {}
                                          },
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          validator: (value) {
                                            if (value.trim().length == 0) {
                                              return 'This field is required';
                                            }
                                            return null;
                                          },
                                          controller: dateinput,
                                          decoration: const InputDecoration(
                                              hintText:
                                                  "Enter Establishment Year"),
                                          enabled: !_status,
                                        ),
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          child: const Text(
                                            'Street',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        flex: 2,
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: const Text(
                                            'Town',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        flex: 2,
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: new TextFormField(
                                            onSaved: (value) {
                                              setState(() {
                                                _street = value;
                                              });
                                            },
                                            keyboardType: TextInputType.text,
                                            textInputAction:
                                                TextInputAction.next,
                                            validator: (value) {
                                              if (value.trim().length == 0) {
                                                return 'This field is required';
                                              }
                                              if (!isAlphanumeric(
                                                  value.replaceAll(' ', ''))) {
                                                return 'Please Enter Valid Value';
                                              }
                                              return null;
                                            },
                                            initialValue:
                                                _street.toString().capitalize(),
                                            decoration: const InputDecoration(
                                                hintText: "Enter Street"),
                                            enabled: !_status,
                                          ),
                                        ),
                                        flex: 2,
                                      ),
                                      Flexible(
                                        child: new TextFormField(
                                          onSaved: (value) {
                                            setState(() {
                                              _town = value;
                                            });
                                          },
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          validator: (value) {
                                            if (value.trim().length == 0) {
                                              return 'This field is required';
                                            }
                                            if (!isAlphanumeric(
                                                value.replaceAll(' ', ''))) {
                                              return 'Please Enter Valid Value';
                                            }
                                            return null;
                                          },
                                          initialValue:
                                              _town.toString().capitalize(),
                                          decoration: const InputDecoration(
                                              hintText: "Enter Town"),
                                          enabled: !_status,
                                        ),
                                        flex: 2,
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          child: const Text(
                                            'District',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        flex: 2,
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: const Text(
                                            'State',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        flex: 2,
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: new TextFormField(
                                            onSaved: (value) {
                                              setState(() {
                                                _district = value;
                                              });
                                            },
                                            keyboardType: TextInputType.text,
                                            textInputAction:
                                                TextInputAction.next,
                                            validator: (value) {
                                              if (value.trim().length == 0) {
                                                return 'This field is required';
                                              }
                                              if (!isAlpha(
                                                  value.replaceAll(' ', ''))) {
                                                return 'Please Enter Valid Value';
                                              }
                                              return null;
                                            },
                                            initialValue: _district
                                                .toString()
                                                .capitalize(),
                                            decoration: const InputDecoration(
                                                hintText: "Enter District"),
                                            enabled: !_status,
                                          ),
                                        ),
                                        flex: 2,
                                      ),
                                      Flexible(
                                        child: IgnorePointer(
                                          ignoring: _status,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                DropdownButtonFormField<String>(
                                                  onSaved: (value) {
                                                    setState(() {
                                                      _state = value;
                                                    });
                                                  },
                                                  isExpanded: true,
                                                  value: dropdownValue,
                                                  onChanged: (String newValue) {
                                                    setState(() {
                                                      dropdownValue = newValue;
                                                    });
                                                  },
                                                  items: statesItems,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        flex: 2,
                                      ),
                                    ],
                                  )),
                              !_status
                                  ? _getActionButtons(_isNew)
                                  : new Container(),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons(bool isNew) {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: const Text("Save"),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: _onSubmit,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: const Text("Cancel"),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                    if (isNew) {
                      Navigator.of(context).pop();
                    }
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: const CircleAvatar(
        backgroundColor: Colors.green,
        radius: 16.0,
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 18.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }

  Widget _getChatIcon() {
    return new GestureDetector(
      child: const CircleAvatar(
        backgroundColor: Colors.green,
        radius: 16.0,
        child: Icon(
          Icons.chat,
          color: Colors.white,
          size: 18.0,
        ),
      ),
      onTap: () {
        // pending
      },
    );
  }

  Widget _getDeleteIcon() {
    return new GestureDetector(
      child: const CircleAvatar(
        backgroundColor: Colors.red,
        radius: 16.0,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 18.0,
        ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text(
              'Do you want to delete this Store ?',
            ),
            actions: <Widget>[
              FlatButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Provider.of<NetworkNotifier>(context, listen: false)
                      .setIsConnected()
                      .then((value) {
                    if (Provider.of<NetworkNotifier>(context, listen: false)
                        .getIsConnected) {
                      int count = 0;
                      Provider.of<StoreProvider>(context, listen: false)
                          .deleteStore(
                        Store(
                          storeId: _storeId,
                          uid: _uid,
                          name: _name,
                          firmId: _firmId,
                          establishmentYear: _establishmentYear,
                          street: _street,
                          town: _town,
                          district: _district,
                          state: _state,
                          isNew: _isNew,
                          timestamp: _timestamp,
                          isDeletd: true,
                        ),
                      )
                          .then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.black,
                            margin: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 40),
                            duration: Duration(seconds: 2),
                            content: const Text('Deleted store sucessfully'),
                          ),
                        );
                        // Navigator.of(context).popUntil((_) => count++ >= 2);
                        Navigator.of(context).pop();
                      });
                    } else {
                      //  Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: const Text(
                            'Please check your network connection',
                          ),
                          duration: Duration(seconds: 1, milliseconds: 200),
                        ),
                      );
                    }
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
