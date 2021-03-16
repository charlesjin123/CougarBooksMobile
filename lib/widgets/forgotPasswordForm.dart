import 'package:flutter/material.dart';
import 'package:uitest/screens/homeScreen.dart';
import 'package:uitest/screens/loginScreen.dart';
import 'package:uitest/widgets/inputTextField.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.90,
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InputTextField(
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email,
                  hint: 'Email Address',
                  validationFunction: (value) {
                    if (value.isEmpty) {
                      return 'Email Address can not be empty';
                    }
                    return null;
                  },
                ),
                Container(
                    margin: EdgeInsets.all(20),
                    child: FlatButton.icon(
                        icon: Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 20,
                        ),
                        label: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 20),
                          child: Text(
                            "Send",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        padding: EdgeInsets.all(12),
                        color: Theme.of(context).accentColor,
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await showDialog<void>(
                                context: context,
                                barrierDismissible:
                                    false, // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                        'Password reset link has been sent successfully.',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500)),
                                    actions: <Widget>[
                                      RaisedButton(
                                          child: Text('Ok',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white)),
                                          color: Theme.of(context).primaryColor,
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LoginScreen()),
                                                    (Route<dynamic> route) =>
                                                        false);
                                          }),
                                    ],
                                  );
                                });
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))))
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            )));
  }
}
