import 'package:flutter/material.dart';

class GettingStarted extends StatelessWidget {
  const GettingStarted({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            SizedBox(
              height: 30,
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
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. \n\nLorem Ipsum has been the industrys standard dummy text ever since the 1500s, \n\nwhen an unknown printer took a galley of type and scrambled it to make a type, specimen book. \n\nIt has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. \n\nIt was popularised in the 1960s with the release of Letraset sheets',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 14),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
