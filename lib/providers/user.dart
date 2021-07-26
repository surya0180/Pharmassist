import 'package:flutter/foundation.dart';
import 'package:pharmassist/helpers/user_info.dart';

class User {
  bool isAdded;
  bool isAdmin;
  final String fullname;
  final String registrationNo;
  final String renewalDate;
  final String street;
  final String town;
  final String district;
  final String state;

  User({
    this.isAdded = false,
    this.isAdmin = true,
    @required this.fullname,
    @required this.registrationNo,
    @required this.renewalDate,
    @required this.street,
    @required this.town,
    @required this.district,
    @required this.state,
  });
}

class UserProvider with ChangeNotifier {
  User _user = User(
    fullname: userInfo["fullname"],
    registrationNo: userInfo["registrationNo"],
    renewalDate: userInfo["renewalDate"],
    street: userInfo["street"],
    town: userInfo["town"],
    district: userInfo["district"],
    state: userInfo["state"],
  );

  User get user {
    return _user;
  }

  void updateUser(User newUser) {
    _user = newUser;
    notifyListeners();
  }
}
