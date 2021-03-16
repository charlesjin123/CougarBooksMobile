import 'package:flutter/material.dart';

import 'package:uitest/data/mockData.dart';
import 'package:uitest/screens/CourseDetailScreen.dart';

class CourseBanner extends StatelessWidget {
  final Course course;
  const CourseBanner({
    Key key,
    this.course,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CourseDetailScreen(
                      title: course.title, imageUrl: course.image)));
            },
            child: Container(
              width: 150,
              height: 100,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  //color: Theme.of(context).primaryColor,
                  image: DecorationImage(
                      image: course.image.startsWith("http")
                          ? NetworkImage(course.image)
                          : AssetImage(course.image),
                      fit: BoxFit.cover)),
            ),
          ),
          SizedBox(height: 2),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Text(
                course.title,
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
            ),
          )
        ],
      ),
    );
  }
}
