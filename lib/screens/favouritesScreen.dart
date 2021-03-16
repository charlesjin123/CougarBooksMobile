import 'package:flutter/material.dart';
import 'package:uitest/widgets/gradientAppBar.dart';
import '../widgets/favouritesCard.dart';
import '../data/mockData.dart';
import '../widgets/coverImage.dart';

class FavouritesScreen extends StatelessWidget {
  final BottomTab tab;
  const FavouritesScreen({
    Key key,
    @required this.tab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Course> favCourses =
        courses.where((element) => element.isFavourited).toList();
    return Scaffold(
      appBar: GradientAppBar(title: tab.title),
      body: ListView.builder(
        itemBuilder: (context, index) {
          var tmpCourse = favCourses[index];
          return Container(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            width: MediaQuery.of(context).size.width * 0.90,
            child: Column(
              children: <Widget>[
                FavouritesCard(
                    author: tmpCourse.author,
                    title: tmpCourse.title,
                    image: CoverImage(
                      imageUrl: tmpCourse.image,
                    )),
                Divider(
                  color: Colors.grey[600],
                  endIndent: 10,
                  indent: 10,
                  height: 10,
                )
              ],
            ),
          );
        },
        itemCount: favCourses.length,
      ),
    );
  }
}
