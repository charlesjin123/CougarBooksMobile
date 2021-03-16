import 'package:flutter/material.dart';
import 'package:uitest/widgets/forgotPasswordForm.dart';
import 'package:uitest/widgets/gradientAppBar.dart';
import 'package:uitest/widgets/inputTextField.dart';

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GradientAppBar(title: 'Forgot Password'),
        body: Container(
            alignment: Alignment.center,
            //width: MediaQuery.of(context).size.width * 0.9,
            //margin: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Icon(
                      Icons.lock_open,
                      color: Theme.of(context).accentColor,
                      size: 55,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Enter the email address associated with your account',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'We will email you a link to reset your password',
                      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),
                  ForgotPassword(),
                ],
              ),
            )));
  }
}
