import 'package:flutter/material.dart';
import 'package:pharmassist/providers/google_sign_in.dart';
import 'package:pharmassist/providers/user.dart';
import 'package:pharmassist/screens/dashboard.dart';
import 'package:pharmassist/screens/store_screen.dart';
import 'package:provider/provider.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _isAdmin =
        Provider.of<UserProvider>(context, listen: false).getIsAdminStatus;
    final _isAdded =
        Provider.of<UserProvider>(context, listen: false).getIsAddedStatus;
    return Drawer(
      elevation: 20,
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text(
              'Pharmassist',
              style: Theme.of(context).textTheme.title,
            ),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              Provider.of<GoogleSignInProvider>(context, listen: false)
                  .logout(context);
            },
          ),
          Divider(),
          _isAdmin == null
              ? ListTile(
                  title: Text('logging out'),
                )
              : _isAdmin
                  ? ListTile(
                      leading: Icon(Icons.dashboard),
                      title: Text('Dashboard'),
                      onTap: () {
                        Navigator.popAndPushNamed(context, Dashboard.routeName);
                      },
                    )
                  : ListTile(
                      leading: Icon(Icons.store),
                      title: Text('Stores'),
                      onTap: () {
                        _isAdded == null
                            ? print('logging out')
                            : !_isAdded
                                ? showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      content: Text(
                                        'Please complete your profile to add a store',
                                        style: TextStyle(
                                            fontFamily: 'poppins',
                                            fontSize: 16),
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text(
                                            'Ok',
                                            style: TextStyle(
                                                fontFamily: 'poppins',
                                                fontSize: 12),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop(true);
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                : Navigator.popAndPushNamed(
                                    context, StoreScreen.routeName);
                      },
                    ),
          Divider(),
          ListTile(
            leading: Icon(Icons.feedback),
            title: Text('Feedback'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
    );
  }
}
