import 'package:flutter/material.dart';

class ExpandableCard extends StatefulWidget {
  final Widget content;
  final String title;
  final double maxHeight;
  const ExpandableCard({
    Key key,
    this.title,
    this.content,
    this.maxHeight,
  }) : super(key: key);

  @override
  _ExpandableCardState createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        width: MediaQuery.of(context).size.width * .9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  )),
            ),
            ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: !_expanded ? widget.maxHeight : double.infinity),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: widget.content,
                )),
            FlatButton(
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                child: Text(_expanded ? 'Show Less' : 'Show More',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Theme.of(context).primaryColor,
                    ))),
          ],
        ),
      ),
    );
  }
}
