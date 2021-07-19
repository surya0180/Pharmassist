import 'package:flutter/material.dart';

class MyDropDown extends StatelessWidget {
  const MyDropDown({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      underline: Container(),
      items: [
        DropdownMenuItem(
          child: Container(
            child: Row(
              children: [
                Icon(Icons.exit_to_app),
                SizedBox(width: 8),
                Text('Logout'),
              ],
            ),
          ),
          value: 'logout',
        ),
      ],
      onChanged: (itemIdentifier) {
        if (itemIdentifier == 'logout') {}
      },
      icon: Icon(
        Icons.more_vert,
        color: Theme.of(context).primaryIconTheme.color,
      ),
    );
  }
}
