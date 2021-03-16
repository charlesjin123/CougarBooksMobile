import 'package:flutter/material.dart';

class CourseHighlights extends StatelessWidget {
  const CourseHighlights({
    Key key,
  }) : super(key: key);

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
              child: Text('This Course Includes',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  )),
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(Icons.library_books),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
              title: Text('5 Articles',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  )),
              dense: true,
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(Icons.view_list),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
              title: Text('Support Files',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  )),
              dense: true,
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(Icons.card_membership),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
              title: Text('Certificate Of Completion',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  )),
              dense: true,
            )
          ],
        ),
      ),
    );
  }
}
