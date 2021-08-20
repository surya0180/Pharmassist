import 'package:flutter/material.dart';
import 'package:pharmassist/providers/auth/google_sign_in.dart';
import 'package:pharmassist/providers/auth/user.dart';
import 'package:pharmassist/screens/admin/dashboard_screen.dart';
import 'package:provider/provider.dart';

class SideDrawer extends StatefulWidget {
  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  var _isLoading;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _isLoading = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _isAdmin =
        Provider.of<UserProvider>(context, listen: false).getIsAdminStatus;
    final _isAdded =
        Provider.of<UserProvider>(context, listen: false).getIsAddedStatus;
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.black38,
            ),
          )
        : Drawer(
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
                    setState(() {
                      _isLoading = true;
                    });
                    Provider.of<GoogleSignInProvider>(context, listen: false)
                        .logout(context)
                        .then((value) {
                      _isLoading = false;
                    });
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
                              Navigator.popAndPushNamed(
                                  context, Dashboard.routeName);
                            },
                          )
                        : ListTile(
                            leading: Icon(Icons.feed_outlined),
                            title: Text('My Requests'),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  content: Text(
                                    'This feature is still under progress',
                                    style: TextStyle(
                                        fontFamily: 'poppins', fontSize: 16),
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
                              );
                            },
                          ),
              ],
            ),
          );
  }
}
