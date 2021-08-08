import 'package:flutter/material.dart';

class RequestCard extends StatelessWidget {
  const RequestCard({
    @required this.title,
    @required this.description,
    @required this.cardColor,
    @required this.route,
    Key key,
  }) : super(key: key);

  final String title;
  final String description;
  final Color cardColor;
  final String route;

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.all(25),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: cardColor,
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(route);
          },
          splashColor: Theme.of(context).canvasColor,
          child: Container(
            height: device.height*0.34,
            padding: EdgeInsets.only(left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: device.height*0.03),
                Text(description),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
