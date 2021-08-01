import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
  var _editedStore = Store(
    isNew: true,
    name: "",
    firmId: "",
    establishmentYear: "",
    street: '',
    town: '',
    district: '',
    state: '',
  );
  var _initValues = {
    "isNew": true,
    "name": "",
    "firmId": "",
    "establishmentYear": "",
    "street": '',
    "town": '',
    "district": '',
    "state": '',
  };
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_init) {
      final storeId = ModalRoute.of(context).settings.arguments as String;
      var store =
          Provider.of<StoreProvider>(context, listen: false).findById(storeId);
      if (store.isNew) {
        setState(() {
          _status = false;
        });
      }
      _init = false;
    }

    super.didChangeDependencies();
  }

  _onSubmit() {
    final isValid = true;
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    Provider.of<StoreProvider>(context, listen: false)
        .createStore(_editedStore);
    setState(() {
      _status = true;
      FocusScope.of(context).requestFocus(new FocusNode());
    });
    Navigator.of(context).pop();
    Navigator.of(context).popAndPushNamed(StoreScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final storeId = ModalRoute.of(context).settings.arguments as String;
    var store = Provider.of<StoreProvider>(context).findById(storeId);
    setState(() {
      _initValues = {
        "isNew": true,
        "name": store.name,
        "firmId": store.firmId,
        "establishmentYear": store.establishmentYear,
        "street": store.street,
        "town": store.town,
        "district": store.district,
        "state": store.state,
      };
    });
    print(store);
    return new Scaffold(
        appBar: AppBar(
          title: store.name != "" ? Text(store.name) : Text("New Store"),
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
                                            ? _getEditIcon()
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
                                          _editedStore = Store(
                                            isNew: _editedStore.isNew,
                                            name: value,
                                            firmId: _editedStore.firmId,
                                            establishmentYear:
                                                _editedStore.establishmentYear,
                                            street: _editedStore.street,
                                            town: _editedStore.town,
                                            district: _editedStore.district,
                                            state: _editedStore.state,
                                          );
                                        },
                                        initialValue: _initValues["name"],
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
                                          _editedStore = Store(
                                            isNew: _editedStore.isNew,
                                            name: _editedStore.name,
                                            firmId: value,
                                            establishmentYear:
                                                _editedStore.establishmentYear,
                                            street: _editedStore.street,
                                            town: _editedStore.town,
                                            district: _editedStore.district,
                                            state: _editedStore.state,
                                          );
                                        },
                                        initialValue: _initValues["firmId"],
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
                                          _editedStore = Store(
                                            isNew: _editedStore.isNew,
                                            name: _editedStore.name,
                                            firmId: _editedStore.firmId,
                                            establishmentYear: value,
                                            street: _editedStore.street,
                                            town: _editedStore.town,
                                            district: _editedStore.district,
                                            state: _editedStore.state,
                                          );
                                        },
                                        initialValue:
                                            _initValues["establishmentYear"],
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
                                            _editedStore = Store(
                                              isNew: _editedStore.isNew,
                                              name: _editedStore.name,
                                              firmId: _editedStore.firmId,
                                              establishmentYear: _editedStore
                                                  .establishmentYear,
                                              street: value,
                                              town: _editedStore.town,
                                              district: _editedStore.district,
                                              state: _editedStore.state,
                                            );
                                          },
                                          initialValue: _initValues['street'],
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
                                          _editedStore = Store(
                                            isNew: _editedStore.isNew,
                                            name: _editedStore.name,
                                            firmId: _editedStore.firmId,
                                            establishmentYear:
                                                _editedStore.establishmentYear,
                                            street: _editedStore.street,
                                            town: value,
                                            district: _editedStore.district,
                                            state: _editedStore.state,
                                          );
                                        },
                                        initialValue: _initValues['town'],
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
                                            _editedStore = Store(
                                              isNew: _editedStore.isNew,
                                              name: _editedStore.name,
                                              firmId: _editedStore.firmId,
                                              establishmentYear: _editedStore
                                                  .establishmentYear,
                                              street: _editedStore.street,
                                              town: _editedStore.town,
                                              district: value,
                                              state: _editedStore.state,
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
                                          _editedStore = Store(
                                            isNew: _editedStore.isNew,
                                            name: _editedStore.name,
                                            firmId: _editedStore.firmId,
                                            establishmentYear:
                                                _editedStore.establishmentYear,
                                            street: _editedStore.street,
                                            town: _editedStore.town,
                                            district: _editedStore.district,
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
                            !_status
                                ? _getActionButtons(_initValues['isNew'])
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
