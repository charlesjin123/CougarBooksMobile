import 'package:flutter/material.dart';
import 'package:uitest/screens/filterScreen.dart';
import 'package:uitest/screens/loginScreen.dart';
import 'package:uitest/screens/searchScreen.dart';
import './badgedIcon.dart';
import './gradientContainer.dart';

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String showActions;
  const GradientAppBar({Key key, @required this.title, this.showActions = ""})
      : super(key: key);

  List<Widget> getActions(showActions, context) {
    if (showActions == 'search') {
      return [
        BadgedIcon(
          iconData: Icons.search,
          onPressAction: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => SearchScreen()));
          },
          badgeCount: 0,
          badgeTextColor: Colors.white,
        ),
      ];
    }

    if (showActions == 'filter') {
      return [
        BadgedIcon(
          iconData: Icons.filter_list,
          onPressAction: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => FilterScreen()));
          },
          badgeCount: 0,
          badgeTextColor: Colors.white,
        ),
      ];
    }

    if (showActions == 'logout') {
      return [
        IconButton(
          onPressed: () async {
            await showDialog<void>(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Do you want to exit ?',
                        style: TextStyle(fontSize: 15)),
                    actions: <Widget>[
                      FlatButton(
                          child: Text('Cancel', style: TextStyle(fontSize: 15)),
                          onPressed: () => Navigator.of(context).pop()),
                      RaisedButton(
                          child: Text('Ok',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white)),
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                                (Route<dynamic> route) => false);
                          }),
                    ],
                  );
                });
          },
          icon: Icon(Icons.exit_to_app),
          color: Colors.white,
          iconSize: 30,
        )
      ];
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(this.title),
        flexibleSpace: GradientContainer(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        centerTitle: true,
        actions: <Widget>[...getActions(showActions, context)]);
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
