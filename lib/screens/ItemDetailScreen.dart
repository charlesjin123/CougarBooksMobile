import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uitest/data/mockData.dart';
import 'package:uitest/screens/videoPlayerScreen.dart';
import 'package:uitest/widgets/expandableCard.dart';
import 'package:uitest/widgets/itemHighlights.dart';
import 'package:uitest/widgets/gradientAppBar.dart';
import 'package:uitest/widgets/item.dart';

class ItemDetailScreen extends StatefulWidget {

  Item item;

  ItemDetailScreen(this.item);

  @override
  _ItemDetailScreenState createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {

  Map<String, dynamic> contact = {};

  void initState() {
    if (widget.item.uid == null) return;
    FirebaseDatabase.instance.reference().child("users/" + widget.item.uid).once()
        .then((datasnapshot) {
      contact["username"] = datasnapshot.value["username"];
      contact["email"] =  datasnapshot.value["email"];
      contact["phone"] = datasnapshot.value["phone"];

      setState(() {});
    }).catchError((error) {
      print("Failed to load user data. ");
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GradientAppBar(title: widget.item.name),
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
                        widget.item.imageUrl != null ? widget.item.imageUrl : "https://complianz.io/wp-content/uploads/2019/03/placeholder-300x202.jpg",
                      ),
                      fit: BoxFit.contain,
                    )),
                  ),
                  SizedBox(height: 15),
                  ItemHighlights(widget.item),
                  ExpandableCard(
                    title: 'Description',
                    maxHeight: 150.0,
                    content: RichText(
                      text: TextSpan(
                        text: widget.item.details + "\nCategories: " + widget.item.category.toString(),
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
            contact["email"] != null ? Card(
              elevation: 2,
              child: Container(
                width: MediaQuery.of(context).size.width * .9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Seller Contact',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          )),
                    ),
                    ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Icon(Icons.email),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
                      title: Text(contact["email"],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700],
                          )),
                      dense: true,
                    ),
                    contact["phone"] != null ? ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Icon(Icons.phone),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
                      title: Text(contact["phone"],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700],
                          )),
                      dense: true,
                    ) : Text(""),
                  ],
                ),
              ),
            ) : Text(""),
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
