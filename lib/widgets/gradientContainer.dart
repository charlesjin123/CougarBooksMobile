import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  final Alignment begin;
  final Alignment end;

  const GradientContainer({
    Key key,
    @required this.begin,
    @required this.end,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
      colors: [Theme.of(context).primaryColor, Theme.of(context).accentColor],
      begin: this.begin,
      end: this.end,
    )));
  }
}
