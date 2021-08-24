import 'package:flutter/material.dart';
import 'package:pharmassist/forms/medical_request_form.dart';
import 'package:pharmassist/forms/pharmacist_request_form.dart';
import 'package:pharmassist/providers/NetworkNotifier.dart';
import 'package:pharmassist/providers/auth/user.dart';
import 'package:pharmassist/widgets/requests/RequestCard.dart';
import 'package:provider/provider.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({Key key}) : super(key: key);

  static const routeName = '/request-screen';

  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<NetworkNotifier>(context, listen: false).setIsConnected();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _isAdded =
        Provider.of<UserProvider>(context, listen: false).getIsAddedStatus;
    final device = MediaQuery.of(context).size;

    return _isAdded
        ? Scaffold(
            body: RefreshIndicator(
              onRefresh: Provider.of<NetworkNotifier>(context).setIsConnected,
              child: Provider.of<NetworkNotifier>(context).getIsConnected
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
                  : ListView(
                      children: const [
                        SizedBox(
                          height: 320,
                        ),
                        Center(
                          child:
                              Text("Something went wrong!  Please try again"),
                        )
                      ],
                    ),
            ),
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.account_box,
                  size: 58,
                  color: Colors.black38,
                ),
                SizedBox(
                  height: device.height * 0.02,
                ),
                Container(
                  width: device.width * 0.6,
                  child: const Text(
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
