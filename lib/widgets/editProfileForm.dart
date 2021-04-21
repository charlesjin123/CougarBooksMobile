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

class EditProfileForm extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfileForm> {
  final _formKey = GlobalKey<FormState>();

  var usernameController = TextEditingController();
  var emailController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usernameController.text = LocalDB.profile["username"];
    emailController.text = LocalDB.profile["email"];
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
                  prefixIcon: Icons.person,
                  hint: 'Username',
                  controller: usernameController,
                ),
                InputTextField(
                  keyboardType: TextInputType.text,
                  prefixIcon: Icons.email,
                  hint: 'Email',
                  controller: emailController,
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
                        onPressed: saveProfile,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))))
              ],
            )));
  }

  void saveProfile() {
    FirebaseDatabase.instance.reference().child("users/" + LocalDB.uid).update(
        {
          "username": usernameController.text,
          "email": emailController.text,
        }
    ).then((value1) {
      Navigator.pop(context);
    }).catchError((error) {
      print("Failed to save profile. " + error.toString());
    });
  }
}

