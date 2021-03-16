import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uitest/data/LocalDB.dart';
import 'package:uitest/screens/homeScreen.dart';
import 'package:uitest/widgets/inputTextField.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        //autovalidate: true,

        child: Container(
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
                  controller: emailController,
                ),
                InputTextField(
                  keyboardType: TextInputType.visiblePassword,
                  prefixIcon: Icons.lock,
                  hint: 'Password',
                  validationFunction: (value) {
                    if (value.isEmpty) {
                      return 'Password can not be empty';
                    }
                    return null;
                  },
                  controller: passwordController,
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
                          padding: const EdgeInsets.only(left: 10, right: 20),
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        padding: EdgeInsets.all(12),
                        color: Theme.of(context).primaryColor,
                        onPressed: () async {
                          await Firebase.initializeApp();
                          FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text)
                              .then((value) {
                            LocalDB.uid = value.user.uid;
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => HomeScreen()),
                            );
                          }).catchError((error) {
                            print(error.toString());
                          });
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))))
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            )));
  }
}
