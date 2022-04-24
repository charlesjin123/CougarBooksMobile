import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uitest/data/LocalDB.dart';
import 'package:uitest/widgets/gradientAppBar.dart';
class ChatScreen extends StatefulWidget {

  var path;

  ChatScreen(this.path) {}

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  var firebaseMessageRoot;
  var otherUsername;
  var otherUid;
  var messageController = TextEditingController();
  var scrollController = ScrollController();

  var messageList = [];


  @override
  void initState() {
    print("initializing chat screen state");
    // if (widget.uid == 'group') {
    //   firebaseMessageRoot = 'group';
    // } else {
    //   if (UserProfile.currentUser['uid'].compareTo(widget.uid.toString()) >= 0) {
    //     firebaseMessageRoot =
    //         UserProfile.currentUser['uid'] + '-' + widget.uid.toString();
    //   } else {
    //     firebaseMessageRoot =
    //         widget.uid.toString() + '-' + UserProfile.currentUser['uid'];
    //   }
    // }

    var uids = widget.path.split("-");
    otherUid = uids[0] == LocalDB.uid ? uids[1] : uids[0];
    FirebaseDatabase.instance.reference().child("users/" + otherUid).once()
        .then((datasnapshot) {
      otherUsername = datasnapshot.value["username"];
      setState(() {});
    }).catchError((error) {
      print("Failed to get other username. ");
      print(error);
    });

    _refreshMessageList();
    LocalDB.chatListener = FirebaseDatabase.instance.reference().child("messages/" + widget.path + "/msgs").onChildAdded.listen((event) {
      //print("refreshing message list for: " + widget.path);
      _refreshMessageList();
    });

    // var messagesRef = FirebaseDatabase.instance.reference().child("messages/" + widget.path + "/msgs");
    // var startKey = messagesRef.push().key;
    // messagesRef.orderByKey().startAt(startKey).onChildAdded.listen((event) {
    //   print("refreshing message list for: " + widget.path);
    //   _refreshMessageList();
    // });
  }

  _ChatScreenState() {

  }

  void _refreshMessageList() {
    if (LocalDB.uid == otherUid) return;
    FirebaseDatabase.instance.reference().child("messages/" + widget.path + "/msgs").once()
        .then((ds) {
      var tmpList = [];
      if (ds.value != null) {
        ds.value.forEach((k, v) {
          //v['image'] = 'https://www.clipartmax.com/png/middle/171-1717870_stockvader-predicted-cron-for-may-user-profile-icon-png.png';
          tmpList.add(v);
        });
        tmpList.sort((a, b) => a['timestamp'].compareTo(b['timestamp']));
        messageList = tmpList;
        FirebaseDatabase.instance.reference().child("users/" + LocalDB.uid + "/messageList/" + otherUid + "/lastViewedMessage")
            .set(messageList[messageList.length-1])
            .then((value) {
          //print(otherUid);
          print("Updated last viewed message. ");
        }).catchError((error) {
          print("Failed to update last viewed message. " + error.toString());
        });
        setState(() {
          Timer(Duration(milliseconds: 100), () {
            scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 250),
            );
          });
          //scrollController.jumpTo(scrollController.position.maxScrollExtent);
        });
      }
    }).catchError((error) {
      print("Failed to load all the messages");
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(title: otherUsername == null ? "" : otherUsername),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                controller: scrollController,
                itemCount: messageList.length,
                itemBuilder: (BuildContext context, int index) {
                  return messageList[index]['uid'] == LocalDB.uid ?
                  Container(
                      margin: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Container(
//                             width: 250,
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.only(bottom: 3),
                                  decoration: new BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: new BorderRadius.all(Radius.circular(5.0))
                                  ),
                                  child: messageList[index]['type'] != null && messageList[index]['type'] == "image" ?
                                  Image.network(messageList[index]['text']) :
                                  Text(messageList[index]['text'], style: TextStyle(fontSize: 17),)
                              ),
                              Text(
                                'Sent at ' + DateTime.fromMillisecondsSinceEpoch(messageList[index]['timestamp']).toString().substring(0, DateTime.fromMillisecondsSinceEpoch(messageList[index]['timestamp']).toString().length-4),
                                style: TextStyle(
                                    fontSize: 12
                                ),
                              ),
                            ],
                          ),
                          // Container(
                          //   margin: EdgeInsets.only(left: 5),
                          //   child: CircleAvatar(
                          //     backgroundImage: NetworkImage('${messageList[index]['image']}'),
                          //   ),
                          // ),
                        ],
                      )
                  ) :
                  Container(
                      margin: EdgeInsets.all(5),
                      child: Row(
                        children: <Widget>[
                          // Container(
                          //   margin: EdgeInsets.only(right: 5),
                          //   child: CircleAvatar(
                          //     backgroundImage: NetworkImage('${messageList[index]['image']}'),
                          //   ),
                          // ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
//                             width: 250,
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.only(bottom: 3),
                                  decoration: new BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: new BorderRadius.all(Radius.circular(5.0))
                                  ),
                                  child: Text(messageList[index]['text'])
                              ),
                              Text(
                                'Sent at ' + DateTime.fromMillisecondsSinceEpoch(messageList[index]['timestamp']).toString().substring(0, DateTime.fromMillisecondsSinceEpoch(messageList[index]['timestamp']).toString().length-4),
                                style: TextStyle(
                                    fontSize: 12
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                  );
                }
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Type your message here',
                    ),
                  ),
                ),
              ),
              // IconButton(
              //   icon: Icon(Icons.photo),
              //   onPressed: () async {
              //     // final cameras = await availableCameras();
              //     // final firstCamera = cameras.first;
              //     //
              //     // final result = await Navigator.push(
              //     //   context,
              //     //   MaterialPageRoute(builder: (context) => TakePictureScreen(camera: firstCamera)),
              //     // );
              //     //
              //     // var timestamp = DateTime.now().millisecondsSinceEpoch;
              //     // var messageRecord = {
              //     //   "text" : result,
              //     //   "type" : "image",
              //     //   "timestamp" : timestamp,
              //     //   "uid" : UserProfile.currentUser['uid']
              //     // };
              //     // FirebaseDatabase.instance.reference().child("message/" + firebaseMessageRoot + "/" + timestamp.toString())
              //     //     .set(messageRecord)
              //     //     .then((value) {
              //     //   print("Added the message!");
              //     //   messageController.text = "";
              //     // }).catchError((error) {
              //     //   print("Failed to add the message");
              //     //   messageController.text = "";
              //     // });
              //
              //   },
              // ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () async {
                  if (messageController.text.length < 1) {
                    await showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Error: ' + "Message cannot be empty.",
                              style: TextStyle(fontSize: 15)),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Ok', style: TextStyle(fontSize: 15)),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        );
                      }
                    );
                  }
                  var timestamp = DateTime.now().millisecondsSinceEpoch;
                  var messageRecord = {
                    "text" : messageController.text,
                    "type" : 'text',
                    "timestamp" : timestamp,
                    "uid" : LocalDB.uid,
                  };
                  FirebaseDatabase.instance.reference().child("messages/" + widget.path + "/lastMessage")
                      .set(messageRecord)
                      .then((value) {
                    print("Set message as latest message in thread. ");
                    messageController.text = "";
                  }).catchError((error) {
                    print("Failed to set message as latest message in thread. " + error.toString());
                    messageController.text = "";
                  });
                  FirebaseDatabase.instance.reference().child("messages/" + widget.path + "/msgs/" + timestamp.toString())
                      .set(messageRecord)
                      .then((value) {
                    print("Added the message!");
                    messageController.text = "";
                  }).catchError((error) {
                    print("Failed to add the message. " + error.toString());
                    messageController.text = "";
                  });
                },
              )
            ],
          )
        ],
      ),
    );
  }
}