import 'package:flutter/material.dart';
import 'package:uitest/widgets/editItemForm.dart';
import 'package:uitest/widgets/editProfileForm.dart';
import 'package:uitest/widgets/gradientAppBar.dart';
import 'package:uitest/widgets/item.dart';
import 'package:uitest/widgets/signupForm.dart';

class EditProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //resizeToAvoidBottomPadding: false,
        appBar: GradientAppBar(title: 'Edit Profile Page'),
        body: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  EditProfileForm(),
                ],
              ),
            ),
          ),
        ));
  }
}
