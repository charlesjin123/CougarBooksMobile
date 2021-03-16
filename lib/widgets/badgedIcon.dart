import 'package:flutter/material.dart';

class BadgedIcon extends StatelessWidget {
  final IconData iconData;
  final Function onPressAction;
  final int badgeCount;
  final Color badgeTextColor;

  const BadgedIcon({
    Key key,
    @required this.iconData,
    @required this.onPressAction,
    this.badgeCount,
    this.badgeTextColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 15),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          IconButton(icon: Icon(iconData), onPressed: onPressAction),
          badgeCount > 0
              ? Positioned(
                  top: 2,
                  right: 2,
                  child: new Container(
                    padding: EdgeInsets.all(3),
                    child: Text(
                      '$badgeCount',
                      style: TextStyle(
                        color: badgeTextColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
