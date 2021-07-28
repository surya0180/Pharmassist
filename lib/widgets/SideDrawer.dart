import 'package:flutter/material.dart';
import 'package:pharmassist/providers/google_sign_in.dart';
import 'package:pharmassist/providers/user.dart';
import 'package:pharmassist/screens/store_screen.dart';
import 'package:provider/provider.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _isAdmin = Provider.of<UserProvider>(context, listen: false).getIsAdminStatus;
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
                  .logout();
            },
          ),
          Divider(),
          _isAdmin ? ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Dashboard'),
            onTap: () {
              Navigator.popAndPushNamed(context, StoreScreen.routeName);
            },
          ) : ListTile(
            leading: Icon(Icons.store),
            title: Text('Add Store'),
            onTap: () {
              Navigator.popAndPushNamed(context, StoreScreen.routeName);
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
