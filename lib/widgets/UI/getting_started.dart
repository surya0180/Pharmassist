import 'package:flutter/material.dart';

class GettingStarted extends StatelessWidget {
  const GettingStarted({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context).size;
    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      backgroundColor: Theme.of(context).canvasColor,
      content: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment(1, 0),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                icon: Icon(Icons.close),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              child: Text(
                'Getting Started . .',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            SizedBox(
              height: device.height * 0.026,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'This is your Profile page , Here you must fill all the details compulsorily and make sure to add valid and leagal Information for better use of app.\n\nYou must complete to bulid your profile before you start using other services of the app. \n\nThis profile is Visible to public ,So please be aware of it and fill your data appropriately',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 14),
              ),
            ),
            SizedBox(
              height: device.height * 0.026,
            ),
          ],
        ),
      ),
    );
  }
}
