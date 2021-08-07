import 'package:flutter/material.dart';
import 'package:uitest/screens/editPostScreen.dart';
import 'package:uitest/screens/filterScreen.dart';
import 'package:uitest/screens/loginScreen.dart';
import 'package:uitest/screens/postFilterScreen.dart';
import 'package:uitest/screens/searchScreen.dart';
import './badgedIcon.dart';
import './gradientContainer.dart';

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String showActions;
  final HomeCallBack homeCallBack;

  const GradientAppBar({Key key, @required this.title, this.showActions = "", this.homeCallBack})
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
          onPressAction: () async {
            await Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => FilterScreen()));
            homeCallBack();
          },
          badgeCount: 0,
          badgeTextColor: Colors.white,
        ),
      ];
    }

    if (showActions == 'post') {
      return [
        BadgedIcon(
          iconData: Icons.post_add,
          onPressAction: () async {
            await Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => EditPostScreen()));
            homeCallBack();
          },
          badgeCount: 0,
          badgeTextColor: Colors.white,
        ),
        BadgedIcon(
          iconData: Icons.post_add,
          onPressAction: () async {
            await Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => EditPostScreen()));
            homeCallBack();
          },
          badgeCount: 0,
          badgeTextColor: Colors.yellow,
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
        leading: showActions == "post" ? BadgedIcon(
          iconData: Icons.filter_list,
          onPressAction: () async {
            await Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => PostFilterScreen()));
            homeCallBack();
          },
          badgeCount: 0,
          badgeTextColor: Colors.white,
        ) : null,
        actions: <Widget>[...getActions(showActions, context)]);
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

typedef HomeCallBack = void Function();