import 'package:flutter/material.dart';
import 'package:pharmassist/forms/medical_request_form.dart';
import 'package:pharmassist/forms/pharmacist_request_form.dart';
import 'package:pharmassist/widgets/RequestCard.dart';

class RequestScreen extends StatelessWidget {
  const RequestScreen({Key key}) : super(key: key);

  static const routeName = '/request-screen';

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
