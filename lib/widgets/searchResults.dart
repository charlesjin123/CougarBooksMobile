import 'package:flutter/material.dart';
import 'package:uitest/data/mockData.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({
    Key key,
    @required this.searchResults,
  }) : super(key: key);

  final List<Course> searchResults;

  @override
  Widget build(BuildContext context) {
    return searchResults.length > 0
        ? ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var tmpCourse = searchResults[index];
              return ListTile(
                  contentPadding: EdgeInsets.all(2),
                  title: Text(tmpCourse.title),
                  subtitle: Text(tmpCourse.author),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(tmpCourse.image),
                    backgroundColor: Colors.black,
                    radius: 25,
                  ));
            },
            itemCount: searchResults.length,
            scrollDirection: Axis.vertical,
          )
        : Center(
            child: Text('No Courses !!',
                style: TextStyle(fontSize: 20, color: Colors.grey[500])));
  }
}
