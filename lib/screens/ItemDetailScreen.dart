import 'package:flutter/material.dart';
import 'package:uitest/data/mockData.dart';
import 'package:uitest/screens/videoPlayerScreen.dart';
import 'package:uitest/widgets/expandableCard.dart';
import 'package:uitest/widgets/itemHighlights.dart';
import 'package:uitest/widgets/gradientAppBar.dart';
import 'package:uitest/widgets/item.dart';

class ItemDetailScreen extends StatelessWidget {

  Item item;

  ItemDetailScreen(this.item);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GradientAppBar(title: item.name),
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
                        item.imageUrl,
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
                  ItemHighlights(item),
                  ExpandableCard(
                    title: 'Description',
                    maxHeight: 150.0,
                    content: RichText(
                      text: TextSpan(
                          text: item.details,
                          ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  // ExpandableCard(
                  //   title: 'Contact',
                  //   maxHeight: 100.0,
                  //   content: RichText(
                  //     text: TextSpan(
                  //         text:
                  //             'Basic programming language will help but is not a must-have',
                  //         style: TextStyle(color: Colors.black, fontSize: 15),
                  //         children: <TextSpan>[
                  //           TextSpan(text: '\n\n'),
                  //           TextSpan(
                  //             text:
                  //                 'You can use either Windows, macOS or Linux for Android app development - iOS apps can only be built on macOS though',
                  //             style:
                  //                 TextStyle(color: Colors.black, fontSize: 15),
                  //           ),
                  //           TextSpan(text: '\n\n'),
                  //           TextSpan(
                  //             text:
                  //                 'NO prior iOS or Android development experience is required',
                  //             style:
                  //                 TextStyle(color: Colors.black, fontSize: 15),
                  //           ),
                  //           TextSpan(text: '\n\n'),
                  //           TextSpan(
                  //             text:
                  //                 'NO prior Flutter or Dart experience is required - this course starts at zero!',
                  //             style:
                  //                 TextStyle(color: Colors.black, fontSize: 15),
                  //           ),
                  //         ]),
                  //     softWrap: true,
                  //     overflow: TextOverflow.fade,
                  //   ),
                  // ),
                ],
              )),
        ));
  }
}
