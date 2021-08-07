import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:pharmassist/helpers/stores.dart';
import 'package:pharmassist/providers/store.dart';
import 'package:pharmassist/screens/store_screen.dart';
import 'package:provider/provider.dart';

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
  // var _initValues = {
  //   "isNew": true,
  //   "name": "",
  //   "firmId": "",
  //   "establishmentYear": "",
  //   "street": '',
  //   "town": '',
  //   "district": '',
  //   "state": '',
  // };
  @override
  void initState() {
    // TODO: implement initState
    dateinput.text = "";
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
      _init = false;
    }

    super.didChangeDependencies();
  }

  _onSubmit() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }

    _formKey.currentState.save();
    if (_isNew == true) {
      Provider.of<StoreProvider>(context, listen: false).createStore(
        Store(
          name: _name,
          firmId: _firmId,
          establishmentYear: _establishmentYear,
          street: _state,
          town: _town,
          district: _district,
          state: _state,
          isNew: _isNew,
          timestamp: Timestamp.now(),
        ),
      );
    } else {
      Provider.of<StoreProvider>(context, listen: false).updateStore(
        Store(
          name: _name,
          firmId: _firmId,
          establishmentYear: _establishmentYear,
          street: _state,
          town: _town,
          district: _district,
          state: _state,
          isNew: _isNew,
          timestamp: _timestamp,
          uid: _uid,
          storeId: _storeId,
        ),
      );
    }
    Navigator.of(context).pop();
    // Navigator.of(context).popAndPushNamed(StoreScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
                                        new Text(
                                          'Store Information',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        _status
                                            ? _uid !=
                                                    FirebaseAuth.instance
                                                        .currentUser.uid
                                                ? new Container()
                                                : _getEditIcon()
                                            : new Container(),
                                      ],
                                    )
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
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
                                padding: EdgeInsets.only(
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
                                          return null;
                                        },
                                        initialValue: _name,
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
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
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
                                padding: EdgeInsets.only(
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
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
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
                                padding: EdgeInsets.only(
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
                                                      2000), //DateTime.now() - not to allow to choose before today.
                                                  lastDate: DateTime(2101));

                                          if (pickedDate != null) {
                                            print(
                                                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                            String formattedDate =
                                                DateFormat('yyyy-MM-dd')
                                                    .format(pickedDate);
                                            print(
                                                formattedDate); //formatted date output using intl package =>  2021-03-16
                                            setState(() {
                                              _establishmentYear =
                                                  formattedDate;
                                              dateinput.text = formattedDate;
                                            });
                                          } else {
                                            print("Date is not selected");
                                          }
                                        },
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.next,
                                        validator: (value) {
                                          if (value.trim().length == 0) {
                                            return 'This field is required';
                                          }
                                          return null;
                                        },
                                        // initialValue: _establishmentYear,
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
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: new Text(
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
                                        child: new Text(
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
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 10.0),
                                        child: new TextFormField(
                                          onSaved: (value) {
                                            setState(() {
                                              _street = value;
                                            });
                                          },
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          validator: (value) {
                                            if (value.trim().length == 0) {
                                              return 'This field is required';
                                            }
                                            return null;
                                          },
                                          initialValue: _street,
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
                                          return null;
                                        },
                                        initialValue: _town,
                                        decoration: const InputDecoration(
                                            hintText: "Enter Town"),
                                        enabled: !_status,
                                      ),
                                      flex: 2,
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: new Text(
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
                                        child: new Text(
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
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 10.0),
                                        child: new TextFormField(
                                          onSaved: (value) {
                                            setState(() {
                                              _district = value;
                                            });
                                          },
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          validator: (value) {
                                            if (value.trim().length == 0) {
                                              return 'This field is required';
                                            }
                                            return null;
                                          },
                                          initialValue: _district,
                                          decoration: const InputDecoration(
                                              hintText: "Enter District"),
                                          enabled: !_status,
                                        ),
                                      ),
                                      flex: 2,
                                    ),
                                    Flexible(
                                      child: new TextFormField(
                                        onSaved: (value) {
                                          setState(() {
                                            _state = value;
                                          });
                                        },
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.done,
                                        validator: (value) {
                                          if (value.trim().length == 0) {
                                            return 'This field is required';
                                          }
                                          return null;
                                        },
                                        initialValue: _state,
                                        decoration: const InputDecoration(
                                            hintText: "Enter State"),
                                        enabled: !_status,
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
        ));
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
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Save"),
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
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Cancel"),
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
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}
