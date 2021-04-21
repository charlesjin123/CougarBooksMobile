import 'package:flutter/material.dart';
import 'package:uitest/widgets/editItemForm.dart';
import 'package:uitest/widgets/editPostForm.dart';
import 'package:uitest/widgets/gradientAppBar.dart';
import 'package:uitest/widgets/item.dart';
import 'package:uitest/widgets/post.dart';
import 'package:uitest/widgets/signupForm.dart';

class EditPostScreen extends StatelessWidget {

  Post post;

  EditPostScreen({Post post}) {
    this.post = post;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //resizeToAvoidBottomPadding: false,
        appBar: GradientAppBar(title: 'Edit Post Page'),
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
                  EditPostForm(post: this.post,),
                ],
              ),
            ),
          ),
        ));
  }
}
