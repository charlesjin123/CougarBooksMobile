import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uitest/data/LocalDB.dart';
import 'package:uitest/data/mockData.dart';
import 'package:uitest/screens/chatScreen.dart';
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
                        text: widget.item.details +
                            "\nCategories: " + (widget.item.category.toString().toLowerCase() != "null" ?
                        (widget.item.category.toString().substring(1, widget.item.category.toString().length-1)) :
                        "None"),
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
                  widget.item.uid != LocalDB.uid ? Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () async {
                        String uid1 = "";
                        String uid2 = "";
                        if (LocalDB.uid.compareTo(widget.item.uid) < 0) {
                          uid1 = LocalDB.uid;
                          uid2 = widget.item.uid;
                        } else {
                          uid1 = widget.item.uid;
                          uid2 = LocalDB.uid;
                        }
                        String path = uid1 + "-" + uid2;
                        FirebaseDatabase.instance.reference().child("messages/" + path).once()
                            .then((datasnapshot) {
                          if (datasnapshot.value == null) {
                            FirebaseDatabase.instance.reference().child("messages/" + path).set(
                                {
                                  "threadID": path,
                                }
                            ).then((value1) {
                              print("Message thread successfully added");
                              FirebaseDatabase.instance.reference().child("users/" + uid1 + "/messageList/" + uid2).set(
                                  {
                                    "path": path,
                                  }
                              ).then((value2) {
                                print("Linked user 2 under user 1");
                              }).catchError((error) {
                                print("Failed to link user 2 under user 1. " + error.toString());
                              });
                              FirebaseDatabase.instance.reference().child("users/" + uid2 + "/messageList/" + uid1).set(
                                  {
                                    "path": path,
                                  }
                              ).then((value2) {
                                print("Linked user 1 under user 2");
                              }).catchError((error) {
                                print("Failed to link user 1 under user 2. " + error.toString());
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ChatScreen(path)),
                              );
                            }).catchError((error) {
                              print("Failed to create message thread. " + error.toString());
                            });
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ChatScreen(path)),
                            );
                          }
                        }).catchError((error) {
                          print("Error with reading conversation path");
                          print(error);
                        });
                      },
                      child: Text("Send Message", style: TextStyle(fontSize: 20)),
                    ),
                  ) : Text(""),
                ],
              )),
        ));
  }
}
