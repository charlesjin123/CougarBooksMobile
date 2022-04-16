import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uitest/data/LocalDB.dart';
import 'package:uitest/screens/PostDetailScreen.dart';
import 'package:uitest/screens/chatScreen.dart';
import 'package:uitest/screens/editItemScreen.dart';
import 'package:uitest/screens/editProfileScreen.dart';
import 'package:uitest/screens/searchScreen.dart';
import 'package:uitest/widgets/contact.dart';
import 'package:uitest/widgets/item.dart';
import 'package:uitest/widgets/post.dart';
import 'package:uitest/widgets/profileProducts.dart';

import '../data/mockData.dart';
import '../widgets/gradientAppBar.dart';
import '../widgets/profileDetail.dart';

class MessagesScreen extends StatefulWidget {
  final BottomTab tab;
  const MessagesScreen({
    Key key,
    this.tab,
  }) : super(key: key);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  List<Contact> contacts;

  void initState() {
    loadContacts();
  }

  String generatePath(String uid1, String uid2) {
    String firstUid = "";
    String secondUid = "";
    if (uid1.compareTo(uid2) < 0) {
      firstUid = uid1;
      secondUid = uid2;
    } else {
      firstUid = uid2;
      secondUid = uid1;
    }
    return firstUid + "-" + secondUid;
  }

  void loadContacts() {
    contacts = [];
    FirebaseDatabase.instance.reference().child("users/" + LocalDB.uid).once()
        .then((datasnapshot) {
      if (datasnapshot.value["messageList"] != null) {
        datasnapshot.value["messageList"].forEach((k1,v1) {
          String contactID = k1.toString();
          int lastViewedTimestamp = v1["lastViewedMessage"] != null ? v1["lastViewedMessage"]["timestamp"] : -1;
          String path = generatePath(LocalDB.uid, contactID);
          FirebaseDatabase.instance.reference().child("users/" + contactID).once()
              .then((datasnapshot1) {
            FirebaseDatabase.instance.reference().child("messages/" + path + "/lastMessage").once()
                .then((datasnapshot2) {
              //print("Last viewed message timestamp in thread: ");
              //print(datasnapshot2.value["timestamp"]);
              //print(contactID);
              int latestTimestamp = datasnapshot2.value != null ? datasnapshot2.value["timestamp"] : -2;
              bool hasUnread = lastViewedTimestamp != latestTimestamp;
              contacts.add(Contact(datasnapshot1.value["username"], contactID, datasnapshot1.value["imageURL"], datasnapshot2.value != null ? datasnapshot2.value["text"] : "", hasUnread));
              setState(() {});
            }).catchError((error) {
              print("Failed to get contact last message and username 2.");
              print(error);
            });
          }).catchError((error) {
            print("Failed to get contact last message and username. ");
            print(error);
          });
        });
      }
    }).catchError((error) {
      print("Failed to load all contacts. ");
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(title: "Messages"),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var tmpContact = contacts[index];
                  return ListTile(
                      onTap: () async {
                        String path = LocalDB.uid.compareTo(tmpContact.uid) < 0 ? LocalDB.uid + "-" + tmpContact.uid : tmpContact.uid + "-" + LocalDB.uid;
                        await Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChatScreen(path)));
                        initState();
                      },
                      contentPadding: EdgeInsets.all(2),
                      title: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                !tmpContact.hasUnread ? CircleAvatar(
                                  backgroundImage: NetworkImage(tmpContact.imageURL != null ? tmpContact.imageURL : profile["userImage"]),
                                  backgroundColor: Colors.black,
                                  radius: 25,
                                ) : new Stack(
                                  children: <Widget>[
                                    new CircleAvatar(
                                      backgroundImage: NetworkImage(tmpContact.imageURL != null ? tmpContact.imageURL : profile["userImage"]),
                                      backgroundColor: Colors.black,
                                      radius: 25,
                                    ),
                                    new Positioned(
                                      right: 0,
                                      child: new Container(
                                        padding: EdgeInsets.all(1),
                                        decoration: new BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(7),
                                        ),
                                        constraints: BoxConstraints(
                                          minWidth: 12,
                                          minHeight: 12,
                                        ),
                                        child: new Text(
                                          "!",
                                          style: new TextStyle(
                                            color: Colors.white,
                                            fontSize: 8,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(tmpContact.username),
                                      Text(
                                        tmpContact.lastMessage,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Divider(
                                color: Theme
                                    .of(context)
                                    .accentColor
                                    .withOpacity(0.8),
                              ),
                            ),
                          ]
                      ),
                      // leading: CircleAvatar(
                      //   backgroundImage: NetworkImage(tmpContact.imageURL != null ? tmpContact.imageURL : profile["userImage"]),
                      //   backgroundColor: Colors.black,
                      //   radius: 25,
                      // )
                  );
                },
                itemCount: contacts.length,
                physics: NeverScrollableScrollPhysics(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


