import 'package:flutter/material.dart';
import 'package:uitest/widgets/gradientAppBar.dart';
import 'package:uitest/widgets/signupForm.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //resizeToAvoidBottomPadding: false,
        appBar: GradientAppBar(title: 'Sign Up'),
        body: Container(
          alignment: Alignment.topCenter,
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
                  SignUpForm(),
                ],
              ),
            ),
          ),
        ));
  }
}
