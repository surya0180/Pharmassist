import 'package:flutter/material.dart';
import 'package:pharmassist/forms/medical_request_form.dart';
import 'package:pharmassist/forms/pharmacist_request_form.dart';
import 'package:pharmassist/providers/user.dart';
import 'package:pharmassist/widgets/RequestCard.dart';
import 'package:pharmassist/widgets/admin_requests.dart';
import 'package:provider/provider.dart';

class RequestScreen extends StatelessWidget {
  const RequestScreen({Key key}) : super(key: key);

  static const routeName = '/request-screen';

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context).size;
    final _isAdded =
        Provider.of<UserProvider>(context, listen: false).getIsAddedStatus;
    return _isAdded
        ? Container(
            child: ListView(
              children: [
                RequestCard(
                  title: 'Medical',
                  description:
                      'Send a request to admin if you want to join a medical shop as pharmacist',
                  cardColor: Colors.cyanAccent[100],
                  route: MedicalRequestForm.routeName,
                ),
                RequestCard(
                  title: 'Pharmacist',
                  description:
                      'Send a request to admin if you are searching for some pharmacists',
                  cardColor: Colors.lightGreenAccent[100],
                  route: PharmacistRequestForm.routeName,
                ),
              ],
            ),
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.account_box,
                  size: 58,
                  color: Colors.black38,
                ),
                SizedBox(
                  height: device.height*0.02,
                ),
                Container(
                  width: device.width*0.6,
                  child: Text(
                    'Please complete your profile to access this page',
                    style: TextStyle(
                      color: Colors.black38,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
