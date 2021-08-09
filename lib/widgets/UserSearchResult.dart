import 'package:flutter/material.dart';
import 'package:pharmassist/screens/profile_screen.dart';

class UserSearchResult extends StatelessWidget {
  const UserSearchResult({
    this.profilePic,
    this.fullname,
    this.registerationNumber,
    this.renewalDate,
    this.street,
    this.town,
    this.district,
    this.state,
    this.uid,
    Key key,
  }) : super(key: key);

  final String profilePic, uid;
  final String fullname;
  final String registerationNumber;
  final String renewalDate;
  final String street, town, district, state;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.black26),
        ),
      ),
      child: InkWell(
        onTap: () {
          print('I am in onTap');
          Navigator.pushNamed(
            context,
            ProfilePage.routeName,
            arguments: {
              'isSearchResult': true,
              'profilePic': profilePic,
              'fullname': fullname,
              'registerationNumber': registerationNumber,
              'renewalDate': renewalDate,
              'street': street,
              'town': town,
              'district': district,
              'state': state,
              'uid': uid,
            },
          );
        },
        splashColor: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          height: 73,
          padding: EdgeInsets.only(left: 14, right: 10, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue[200],
                    backgroundImage: NetworkImage(profilePic),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.06,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fullname,
                        style: Theme.of(context).textTheme.title,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.008,
                      ),
                      Text(
                        'Reg-no:  $registerationNumber',
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
