import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:uitest/data/mockData.dart';
import 'package:uitest/widgets/gradientAppBar.dart';
import '../widgets/courseCard.dart';
import '../widgets/coverImage.dart';

class CoursesScreen extends StatelessWidget {
  final BottomTab tab;
  const CoursesScreen({
    Key key,
    this.tab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Course> enrolledCourse =
        courses.where((element) => element.isEnrolled).toList();
    return Scaffold(
        appBar: GradientAppBar(title: tab.title),
        body: ListView.builder(
          itemBuilder: (context, index) {
            var tmpCourse = enrolledCourse[index];
            return Container(
              width: MediaQuery.of(context).size.width * 0.90,
              child: FractionallySizedBox(
                widthFactor: 1,
                child: CourseCard(
                  isFavourited: tmpCourse.isFavourited,
                  author: tmpCourse.author,
                  title: tmpCourse.title,
                  image: CoverImage(
                    imageUrl: tmpCourse.image,
                  ),
                  completed: tmpCourse.completedPercentage,
                ),
              ),
            );
          },
          itemCount: enrolledCourse.length,
        ));
  }
}
