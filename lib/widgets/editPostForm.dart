import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:uitest/data/LocalDB.dart';
import 'package:uitest/screens/accountScreen.dart';
import 'package:uitest/screens/loginScreen.dart';
import 'package:uitest/widgets/inputTextField.dart';
import 'package:uitest/widgets/item.dart';
import 'package:uitest/widgets/post.dart';

class EditPostForm extends StatefulWidget {
  Post post;

  EditPostForm({Post post}) {
    this.post = post;
  }

  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPostForm> {
  final _formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var detailsController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController.text = widget.post?.title;
    detailsController.text = widget.post?.details;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.90,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                InputTextField(
                  keyboardType: TextInputType.text,
                  prefixIcon: Icons.label,
                  hint: 'Post Title',
                  controller: titleController,
                ),
                InputTextField(
                  keyboardType: TextInputType.text,
                  prefixIcon: Icons.description,
                  hint: 'Post Description',
                  controller: detailsController,
                ),
                Container(
                    margin: EdgeInsets.all(20),
                    child: FlatButton.icon(
                        icon: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 20,
                        ),
                        label: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 20.0),
                          child: Text(
                            "Save",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                letterSpacing: 1),
                          ),
                        ),
                        padding: EdgeInsets.all(12),
                        color: Theme.of(context).accentColor,
                        onPressed: savePost,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))))
              ],
            )));
  }

  void savePost() {
    var timestamp = new DateTime.now().millisecondsSinceEpoch;
    String path = timestamp.toString();
    if (widget.post != null) {
      path = widget.post.id;
    }
    FirebaseDatabase.instance.reference().child("users/" + LocalDB.uid + "/posts/post" + path).set(
        {
          "title": titleController.text,
          "details": detailsController.text,
          "id": path,
          "uid": LocalDB.uid,
          "timestamp": DateTime.now().millisecondsSinceEpoch,
        }
    ).then((value1) {
      Navigator.pop(context);
    }).catchError((error) {
      print("Failed to add post. " + error.toString());
    });
  }
}

