import 'package:flutter/material.dart';
import 'package:uitest/data/mockData.dart';
import 'package:uitest/screens/videoPlayerScreen.dart';
import 'package:uitest/widgets/expandableCard.dart';
import 'package:uitest/widgets/courseHighlights.dart';
import 'package:uitest/widgets/gradientAppBar.dart';

class CourseDetailScreen extends StatelessWidget {
  final String title;
  final String imageUrl;
  const CourseDetailScreen({
    Key key,
    this.title,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GradientAppBar(title: title),
        body: SingleChildScrollView(
          child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 15),
                  Container(
                    height: MediaQuery.of(context).size.height * .3,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: NetworkImage(
                        imageUrl,
                      ),
                      fit: BoxFit.contain,
                    )),
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: MediaQuery.of(context).size.width * .9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3)),
                            color: Theme.of(context).primaryColor,
                            onPressed: () {},
                            //icon: Icon(Icons.event_note, color: Colors.white),
                            child: Text('Add to My Course',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: FlatButton(
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3)),
                            color: Theme.of(context).primaryColor,
                            // icon: Icon(Icons.favorite_border,
                            //     color: Colors.white),
                            child: Text('Add to Whislist',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CourseHighlights(),
                  ExpandableCard(
                    title: 'Description',
                    maxHeight: 150.0,
                    content: RichText(
                      text: TextSpan(
                          text:
                              'This Course was completely re-recoreded and updated - it\'s totally up-to-date with the latest version of Flutter!',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                          children: <TextSpan>[
                            TextSpan(text: '\n\n'),
                            TextSpan(
                              text:
                                  'With the latest update, I also added Push Notifications and Image Upload !',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            TextSpan(text: '\n\n'),
                            TextSpan(
                              text:
                                  'Flutter - a framework developed by Google - allows you to learn one language (Dart) and build beautiful native mobile apps in no time. Flutter is a SDK providing the tooling to compile Dart code into native code and it also gives you a rich set of pre-built and pre-styled UI elements (so called widgets) which you can use to compose your user interfaces.',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            TextSpan(text: '\n\n'),
                            TextSpan(
                              text:
                                  'This course will teach Flutter & Dart from scratch, NO prior knowledge of either of the two is required! And you certainly don\'t need any Android or iOS development experience since the whole idea behind Flutter is to only learn one language.',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            TextSpan(text: '\n\n'),
                            TextSpan(
                              text:
                                  'You\'ll learn Flutter not only in theory but we\'ll build a complete, realistic app throughout this course. This app will feature both all the core basics as well as advanced features like using Google Maps, the device camera, adding animations and more!',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ]),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  ExpandableCard(
                    title: 'Requirements',
                    maxHeight: 100.0,
                    content: RichText(
                      text: TextSpan(
                          text:
                              'Basic programming language will help but is not a must-have',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                          children: <TextSpan>[
                            TextSpan(text: '\n\n'),
                            TextSpan(
                              text:
                                  'You can use either Windows, macOS or Linux for Android app development - iOS apps can only be built on macOS though',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            TextSpan(text: '\n\n'),
                            TextSpan(
                              text:
                                  'NO prior iOS or Android development experience is required',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            TextSpan(text: '\n\n'),
                            TextSpan(
                              text:
                                  'NO prior Flutter or Dart experience is required - this course starts at zero!',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ]),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  ExpandableCard(
                    title: 'Curriculum',
                    maxHeight: 200.0,
                    content: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => Card(
                        elevation: 5.0,
                        child: ListTile(
                          onTap: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => VideoPlayerScreen()));
                          },
                          leading: CircleAvatar(child: Text('${index + 1}')),
                          title: Text(curriculum[index]['title']),
                          subtitle: Text(curriculum[index]['duration']),
                          contentPadding: EdgeInsets.only(left: 15),
                        ),
                      ),
                      itemCount: curriculum.length,
                    ),
                  )
                ],
              )),
        ));
  }
}
