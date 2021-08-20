import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:pharmassist/providers/NetworkNotifier.dart';
import 'package:pharmassist/widgets/UI/getting_started.dart';
import 'package:pharmassist/providers/profileEditStatus.dart';
import 'package:pharmassist/providers/auth/user.dart';
import 'package:pharmassist/screens/chat/chat_screen.dart';
import 'package:provider/provider.dart';
import '../../helpers/states.dart';
import 'package:string_validator/string_validator.dart';

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

  bool _isSearchResult;
  String _profilePic;
  String _fullname;
  String _registerationNumber;
  String _renewalDate;
  String _street;
  String _town;
  String _district;
  String _state;
  String _uid;

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
  TextEditingController dateinput = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController registrationNo = TextEditingController();

  TextEditingController street = TextEditingController();
  TextEditingController town = TextEditingController();
  TextEditingController district = TextEditingController();

  String stateInput;
  String dropdownValue;

  var states = items;

  @override
  void initState() {
    Provider.of<NetworkNotifier>(context, listen: false).setIsConnected();
    dateinput.text = "";
    dropdownValue = "maharashtra";

    fullname.text = "";
    registrationNo.text = "";

    street.text = "";
    town.text = "";
    district.text = "";

    // TODO: implement initState
    var _isAdded =
        Provider.of<UserProvider>(context, listen: false).getIsAddedStatus;
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
      dateinput.text = _initValues["renewalDate"];
      dropdownValue = _initValues["state"].toLowerCase().toString();
      fullname.text = userinfo.fullname;
      registrationNo.text = userinfo.registrationNo;

      street.text = userinfo.street;
      town.text = userinfo.town;
      district.text = userinfo.district;

      _status = userinfo.isAdded;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Provider.of<ProfileEditStatus>(context, listen: false)
            .setIsEditing(!userinfo.isAdded);
      });
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
    final isValid = _formKey.currentState.validate();
    Provider.of<ProfileEditStatus>(context, listen: false).setIsEditingFalse();
    if (!isValid) {
      return;
    }
    Provider.of<NetworkNotifier>(context, listen: false)
        .setIsConnected()
        .then((value) {
      if (Provider.of<NetworkNotifier>(context, listen: false).getIsConnected) {
        _formKey.currentState.save();
        Provider.of<UserProvider>(context, listen: false)
            .updateUser(_editedUser)
            .then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.black,
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 40),
              duration: Duration(seconds: 1),
              content: Text(
                'Updated profile sucessfully',
              ),
            ),
          );
        });
        setState(() {
          _status = true;
          FocusScope.of(context).requestFocus(new FocusNode());
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
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
    final device = MediaQuery.of(context).size;
    final userinfo = Provider.of<UserProvider>(context, listen: false).user;
    final _isAdmin =
        Provider.of<UserProvider>(context, listen: false).getIsAdminStatus;
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    if (routeArgs != null) {
      setState(() {
        _isSearchResult = routeArgs['isSearchResult'];
        _profilePic = routeArgs['profilePic'];
        _fullname = routeArgs['fullname'];
        _registerationNumber = routeArgs['registerationNumber'];
        _renewalDate = routeArgs['renewalDate'];
        _street = routeArgs['street'];
        _town = routeArgs['town'];
        _district = routeArgs['district'];
        _state = routeArgs['state'];
        _uid = routeArgs['uid'];
        dateinput.text = _renewalDate;
        dropdownValue = _state.toLowerCase().toString();
        fullname.text = _fullname;
        registrationNo.text = _registerationNumber;
        street.text = _street;
        town.text = _town;
        district.text = _district;
      });
    }
    print(_isSearchResult);
    return new Scaffold(
        appBar: _isSearchResult != null ? AppBar() : null,
        body: RefreshIndicator(
          onRefresh: Provider.of<NetworkNotifier>(context, listen: false)
              .setIsConnected,
          child: new Container(
            color: Colors.white,
            child: new ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    new Container(
                      height: device.height * 0.31,
                      color: Colors.white,
                      child: new Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Center(
                              child: Text(
                                _isSearchResult != null
                                    ? _fullname
                                    : userinfo.fullname,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: new Stack(
                                fit: StackFit.loose,
                                children: <Widget>[
                                  new Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Container(
                                          width: device.height * 0.18,
                                          height: device.height * 0.18,
                                          // child: Image.network(_isSearchResult != null
                                          //     ? _profilePic
                                          //     : userinfo.photoUrl),
                                          decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: new DecorationImage(
                                              image: NetworkImage(
                                                  _isSearchResult != null
                                                      ? _profilePic
                                                      : userinfo.photoUrl),
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
                                            'Personal Information',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        // mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          _status
                                              ? _isSearchResult != null
                                                  ? new Container()
                                                  : _getEditIcon()
                                              : new Container(),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          _status
                                              ? _isAdmin
                                                  ? _isSearchResult == null
                                                      ? new Container()
                                                      : _isSearchResult !=
                                                                  null &&
                                                              _uid ==
                                                                  fa
                                                                      .FirebaseAuth
                                                                      .instance
                                                                      .currentUser
                                                                      .uid
                                                          ? new Container()
                                                          : _getMessageIcon()
                                                  : new Container()
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
                                              fullname: value.trim(),
                                              registrationNo:
                                                  _editedUser.registrationNo,
                                              renewalDate:
                                                  _editedUser.renewalDate,
                                              street: _editedUser.street,
                                              town: _editedUser.town,
                                              district: _editedUser.district,
                                              state: _editedUser.state,
                                            );
                                          },
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
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
                                          controller: fullname,
                                          // initialValue: _isSearchResult != null
                                          //     ? _fullname
                                          //     : _initValues["fullName"],
                                          decoration: const InputDecoration(
                                            hintText: "Enter Your Name",
                                          ),
                                          enabled: !_status,
                                          autofocus: !_status,
                                        ),
                                      ),
                                    ],
                                  )),
                              if (!_isAdmin ||
                                  _isSearchResult != null &&
                                      _isSearchResult &&
                                      registrationNo.text != "")
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
                                              'Registration Number',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                              if (!_isAdmin ||
                                  _isSearchResult != null &&
                                      _isSearchResult &&
                                      registrationNo.text != "")
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
                                                registrationNo: value.trim(),
                                                renewalDate:
                                                    _editedUser.renewalDate,
                                                street: _editedUser.street,
                                                town: _editedUser.town,
                                                district: _editedUser.district,
                                                state: _editedUser.state,
                                              );
                                            },
                                            keyboardType: TextInputType.text,
                                            textInputAction:
                                                TextInputAction.next,
                                            validator: (value) {
                                              if (value.trim().length == 0) {
                                                return null;
                                              }
                                              if (!isAlphanumeric(
                                                  value.replaceAll(' ', ''))) {
                                                return 'Please Enter Valid Value';
                                              }
                                              return null;
                                            },
                                            controller: registrationNo,
                                            // initialValue: _isSearchResult != null
                                            //     ? _registerationNumber
                                            //     : _initValues["registrationNo"],
                                            decoration: const InputDecoration(
                                                hintText:
                                                    "Enter registration number (Optional)"),
                                            enabled: !_status,
                                          ),
                                        ),
                                      ],
                                    )),
                              if (!_isAdmin ||
                                  _isSearchResult != null &&
                                      _isSearchResult &&
                                      dateinput.text != "")
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
                                              "Renewal Date",
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                              if (!_isAdmin ||
                                  _isSearchResult != null &&
                                      _isSearchResult &&
                                      dateinput.text != "")
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 2.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Flexible(
                                          child: new TextFormField(
                                            onTap: () async {
                                              DateTime pickedDate =
                                                  await showDatePicker(
                                                      context:
                                                          context, //context of current state
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(
                                                          2015), //DateTime.now() - not to allow to choose before today.
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
                                                  _initValues["renewalDate"] =
                                                      formattedDate;
                                                  dateinput.text =
                                                      formattedDate;
                                                });
                                              } else {
                                                print("Date is not selected");
                                              }
                                            },
                                            readOnly: true,
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
                                            keyboardType: TextInputType.text,
                                            textInputAction:
                                                TextInputAction.next,
                                            validator: (value) {
                                              // if (value.trim().length == 0) {
                                              //   return 'This field is required';
                                              // }
                                              return null;
                                            },
                                            controller: dateinput,
                                            decoration: const InputDecoration(
                                                hintText:
                                                    "Enter renewal date (Optional)"),
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
                                                renewalDate:
                                                    _editedUser.renewalDate,
                                                street: value.trim(),
                                                town: _editedUser.town,
                                                district: _editedUser.district,
                                                state: _editedUser.state,
                                              );
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
                                            controller: street,
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
                                              renewalDate:
                                                  _editedUser.renewalDate,
                                              street: _editedUser.street,
                                              town: value.trim(),
                                              district: _editedUser.district,
                                              state: _editedUser.state,
                                            );
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
                                          controller: town,
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
                                                renewalDate:
                                                    _editedUser.renewalDate,
                                                street: _editedUser.street,
                                                town: _editedUser.town,
                                                district: value.trim(),
                                                state: _editedUser.state,
                                              );
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
                                            controller: district,
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
                                                    _editedUser = User(
                                                      isAdded:
                                                          _editedUser.isAdded,
                                                      fullname:
                                                          _editedUser.fullname,
                                                      registrationNo:
                                                          _editedUser
                                                              .registrationNo,
                                                      renewalDate: _editedUser
                                                          .renewalDate,
                                                      street:
                                                          _editedUser.street,
                                                      town: _editedUser.town,
                                                      district:
                                                          _editedUser.district,
                                                      state: value.trim(),
                                                    );
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
          ),
        ));
  }

  @override
  void dispose() {
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
                onPressed: () {
                  final userinfo =
                      Provider.of<UserProvider>(context, listen: false).user;
                  Provider.of<ProfileEditStatus>(context, listen: false)
                      .setIsEditingFalse();
                  setState(() {
                    dateinput.text = userinfo.renewalDate;
                    dropdownValue = userinfo.state.toLowerCase().toString();
                    fullname.text = userinfo.fullname;
                    registrationNo.text = userinfo.registrationNo;

                    street.text = userinfo.street;
                    town.text = userinfo.town;
                    district.text = userinfo.district;

                    _status = userinfo.isAdded;
                    _status = true;
                  });
                  print(_status);
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
        radius: 20.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 18.0,
        ),
      ),
      onTap: () {
        Provider.of<ProfileEditStatus>(context, listen: false)
            .setIsEditingTrue();
        setState(() {
          _status = false;
        });
      },
    );
  }

  Widget _getMessageIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.green,
        radius: 20.0,
        child: new Icon(
          Icons.chat,
          color: Colors.white,
          size: 18.0,
        ),
      ),
      onTap: () {
        print(_uid);
        print('above is the required uid');
        Provider.of<NetworkNotifier>(context, listen: false)
            .setIsConnected()
            .then((value) {
          if (Provider.of<NetworkNotifier>(context, listen: false)
              .getIsConnected) {
            Navigator.of(context).pushNamed(ChatScreen.routeName,
                arguments: {'name': _fullname, 'userId': _uid});
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  'Please check your network connection',
                ),
                duration: Duration(seconds: 1, milliseconds: 200),
              ),
            );
          }
        });
      },
    );
  }
}
