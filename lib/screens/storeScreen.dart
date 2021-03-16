import 'package:flutter/material.dart';

import 'package:uitest/data/mockData.dart';
import 'package:uitest/widgets/gradientAppBar.dart';
import '../widgets/headerTitle.dart';
import '../widgets/courseBanner.dart';

class StoreScreen extends StatelessWidget {
  final BottomTab tab;
  const StoreScreen({
    Key key,
    this.tab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GradientAppBar(title: tab.title, showActions: "search"),
        body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  HeaderTitle(text: 'New Arrivals'),
                  Container(
                    height: 150,
                    margin: EdgeInsets.only(top: 10),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        courses.shuffle();
                        var tmpCourse = courses[index];
                        return Container(
                            padding: EdgeInsets.only(left: 5, right: 5),
                            child: CourseBanner(
                              course: tmpCourse,
                            ));
                      },
                      itemCount: courses.length,
                    ),
                  ),
                  //SizedBox(height: 125),
                  HeaderTitle(text: 'Trending Products'),
                  Container(
                    height: 150,
                    margin: EdgeInsets.only(top: 10),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        var tmpCourse = courses.skip(4).toList()[index];
                        return Container(
                            padding: EdgeInsets.only(left: 5, right: 5),
                            child: CourseBanner(
                              course: tmpCourse,
                            ));
                      },
                      itemCount: courses.skip(4).toList().length,
                    ),
                  ),
                  HeaderTitle(text: 'Top Picks'),
                  Container(
                    height: 150,
                    margin: EdgeInsets.only(top: 10),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        courses.shuffle();
                        var tmpCourse = courses.skip(2).toList()[index];
                        return Container(
                            padding: EdgeInsets.only(left: 5, right: 5),
                            child: CourseBanner(
                              course: tmpCourse,
                            ));
                      },
                      itemCount: courses.skip(2).toList().length,
                    ),
                  ),
                ],
              )),
        ));
  }
}
