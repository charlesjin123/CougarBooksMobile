import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uitest/data/mockData.dart';
import 'package:uitest/screens/videoPlayerScreen.dart';
import 'package:uitest/widgets/expandableCard.dart';
import 'package:uitest/widgets/itemHighlights.dart';
import 'package:uitest/widgets/gradientAppBar.dart';
import 'package:uitest/widgets/item.dart';
import 'package:uitest/widgets/post.dart';

class PostDetailScreen extends StatefulWidget {

  Post post;

  PostDetailScreen(this.post);

  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {

  Map<String, dynamic> contact = {};

  void initState() {
    if (widget.post.uid == null) return;
    FirebaseDatabase.instance.reference().child("users/" + widget.post.uid).once()
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
        appBar: GradientAppBar(title: "Post Details"),
        body: SingleChildScrollView(
          child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Card(
                    elevation: 2,
                    child: Container(
                      width: MediaQuery.of(context).size.width * .9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(widget.post.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                )),
                          ),
                          RichText(
                            text: TextSpan(
                              text: widget.post.details,
                              style: TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                        ],
                      ),
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
                            child: Text('Poster Contact',
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
                ],
              )),
        ));
  }
}
