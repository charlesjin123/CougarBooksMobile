import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uitest/data/LocalDB.dart';
import 'package:uitest/widgets/item.dart';
import '../data/mockData.dart';

class ProfileDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        ProfileItem(
            icon: Icons.person,
            text: LocalDB.profile == null ? "" : LocalDB.profile["username"]),
        Divider(
          color: Theme.of(context).accentColor.withOpacity(0.8),
        ),
        // ProfileItem(icon: Icons.cake, text: profile['dob']),
        // Divider(
        //   color: Theme.of(context).accentColor.withOpacity(0.8),
        // ),
        ProfileItem(icon: Icons.email, text: LocalDB.profile == null ? "" : LocalDB.profile["email"]),
        Divider(
          color: Theme.of(context).accentColor.withOpacity(0.8),
        ),
        // ProfileItem(icon: Icons.phone_android, text: profile['phone']),
        // Divider(
        //   color: Theme.of(context).accentColor.withOpacity(0.8),
        // ),
      ],
    ));
  }
}

class ProfileItem extends StatelessWidget {
  final String text;
  final IconData icon;

  const ProfileItem({
    Key key,
    @required this.text,
    @required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
          child: Icon(
            icon,
            color: Theme.of(context).accentColor,
            size: 30,
          ),
        ),
        Text(text, style: TextStyle(fontSize: 15)),
      ],
    );
  }
}
