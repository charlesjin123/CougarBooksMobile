import 'package:flutter/material.dart';

class HeaderTitle extends StatelessWidget {
  final String text;
  const HeaderTitle({
    Key key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        child: Text(text,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)));
  }
}
