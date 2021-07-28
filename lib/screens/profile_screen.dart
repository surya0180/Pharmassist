import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pharmassist/forms/getting_started.dart';
import 'package:pharmassist/providers/user.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  static final routeName = "/profile-page";
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey();

  var _editedUser = User(
    isAdded: true,
    fullname: '',
    registrationNo: "",
    renewalDate: '',
    street: '',
    town: '',
    district: '',
    state: '',
  );
  var _initValues = {
    "fullName": '',
    "registrationNo": "",
    "renewalDate": '',
    "street": '',
    "town": '',
    "district": '',
    "state": '',
  };

  @override
  void initState() {
    // TODO: implement initState
    var _isAdded = Provider.of<UserProvider>(context, listen: false).getIsAddedStatus;
    final userinfo = Provider.of<UserProvider>(context, listen: false).user;
    setState(() {
      _initValues = {
        "fullName": userinfo.fullname,
        "registrationNo": userinfo.registrationNo,
        "renewalDate": userinfo.renewalDate,
        "street": userinfo.street,
        "town": userinfo.town,
        "district": userinfo.district,
        "state": userinfo.state,
      };
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isAdded) {
        showDialog(
          context: context,
          builder: (_) => GettingStarted(),
        );
      }
    });
    super.initState();
  }

  _onSubmit() {
    final isValid = true;
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    Provider.of<UserProvider>(context, listen: false).updateUser(_editedUser);
    setState(() {
      _status = true;
      FocusScope.of(context).requestFocus(new FocusNode());
    });
  }

  @override
  Widget build(BuildContext context) {
    final userinfo = Provider.of<UserProvider>(context, listen: false).user;
    return new Scaffold(
        body: new Container(
      color: Colors.white,
      child: new ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              new Container(
                height: 250.0,
                color: Colors.white,
                child: new Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Center(
                        child: Text(
                          userinfo.fullname,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: new Stack(fit: StackFit.loose, children: <Widget>[
                        new Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                                width: 140.0,
                                height: 140.0,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                    image: new ExactAssetImage(
                                        'assets/images/as.png'),
                                    fit: BoxFit.cover,
                                  ),
                                )),
                          ],
                        ),
                      ]),
                    )
                  ],
                ),
              ),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'Parsonal Information',
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
                                    _status ? _getEditIcon() : new Container(),
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'Full Name',
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
                                      _editedUser = User(
                                        isAdded: _editedUser.isAdded,
                                        fullname: value,
                                        registrationNo:
                                            _editedUser.registrationNo,
                                        renewalDate: _editedUser.renewalDate,
                                        street: _editedUser.street,
                                        town: _editedUser.town,
                                        district: _editedUser.district,
                                        state: _editedUser.state,
                                      );
                                    },
                                    initialValue: _initValues["fullName"],
                                    decoration: const InputDecoration(
                                      hintText: "Enter Your Name",
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'Registration Number',
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
                                      _editedUser = User(
                                        isAdded: _editedUser.isAdded,
                                        fullname: _editedUser.fullname,
                                        registrationNo: value,
                                        renewalDate: _editedUser.renewalDate,
                                        street: _editedUser.street,
                                        town: _editedUser.town,
                                        district: _editedUser.district,
                                        state: _editedUser.state,
                                      );
                                    },
                                    initialValue: _initValues["registrationNo"],
                                    decoration: const InputDecoration(
                                        hintText: "Enter registration no"),
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      "Renewel Date",
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
                                      _editedUser = User(
                                        isAdded: _editedUser.isAdded,
                                        fullname: _editedUser.fullname,
                                        registrationNo:
                                            _editedUser.registrationNo,
                                        renewalDate: value,
                                        street: _editedUser.street,
                                        town: _editedUser.town,
                                        district: _editedUser.district,
                                        state: _editedUser.state,
                                      );
                                    },
                                    initialValue: _initValues["renewalDate"],
                                    decoration: const InputDecoration(
                                        hintText: "Enter renewal_date"),
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
                                        _editedUser = User(
                                          isAdded: _editedUser.isAdded,
                                          fullname: _editedUser.fullname,
                                          registrationNo:
                                              _editedUser.registrationNo,
                                          renewalDate: _editedUser.renewalDate,
                                          street: value,
                                          town: _editedUser.town,
                                          district: _editedUser.district,
                                          state: _editedUser.state,
                                        );
                                      },
                                      initialValue: _initValues["street"],
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
                                      _editedUser = User(
                                        isAdded: _editedUser.isAdded,
                                        fullname: _editedUser.fullname,
                                        registrationNo:
                                            _editedUser.registrationNo,
                                        renewalDate: _editedUser.renewalDate,
                                        street: _editedUser.street,
                                        town: value,
                                        district: _editedUser.district,
                                        state: _editedUser.state,
                                      );
                                    },
                                    initialValue: _initValues["town"],
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
                                        _editedUser = User(
                                          isAdded: _editedUser.isAdded,
                                          fullname: _editedUser.fullname,
                                          registrationNo:
                                              _editedUser.registrationNo,
                                          renewalDate: _editedUser.renewalDate,
                                          street: _editedUser.street,
                                          town: _editedUser.town,
                                          district: value,
                                          state: _editedUser.state,
                                        );
                                      },
                                      initialValue: _initValues["district"],
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
                                      _editedUser = User(
                                        isAdded: _editedUser.isAdded,
                                        fullname: _editedUser.fullname,
                                        registrationNo:
                                            _editedUser.registrationNo,
                                        renewalDate: _editedUser.renewalDate,
                                        street: _editedUser.street,
                                        town: _editedUser.town,
                                        district: _editedUser.district,
                                        state: value,
                                      );
                                    },
                                    initialValue: _initValues["state"],
                                    decoration: const InputDecoration(
                                        hintText: "Enter State"),
                                    enabled: !_status,
                                  ),
                                  flex: 2,
                                ),
                              ],
                            )),
                        !_status ? _getActionButtons() : new Container(),
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

  Widget _getActionButtons() {
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
                onPressed: () {},
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
