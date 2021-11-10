import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uitest/data/LocalDB.dart';
import 'package:uitest/screens/loginScreen.dart';
import 'package:uitest/screens/takePictureScreen.dart';
import 'package:uitest/widgets/inputTextField.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var imageURL;

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
                Container(
                  height: 200,
                  child: imageURL != null ? Image.network(imageURL) : Image.network("https://complianz.io/wp-content/uploads/2019/03/placeholder-300x202.jpg"),
                ),
                Container(
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () async {
                      final cameras = await availableCameras();
                      final firstCamera = cameras.first;
                      var newURL = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TakePictureScreen(camera: firstCamera, type: "profile")),
                      );
                      imageURL = newURL != null ? newURL : imageURL;
                      setState(() {});
                    },
                    child: Text("Take Profile Picture", style: TextStyle(fontSize: 20)),
                  ),
                ),
                InputTextField(
                  keyboardType: TextInputType.text,
                  prefixIcon: Icons.person,
                  hint: 'Username',
                  validationFunction: (value) {
                    if (value.isEmpty) {
                      return 'Username is required';
                    }
                    return null;
                  },
                  controller: usernameController,
                ),
                InputTextField(
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email,
                  hint: 'Email Address',
                  validationFunction: (value) {
                    if (value.isEmpty) {
                      return 'Email Address is required';
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
                      return 'Password is required';
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
                          padding: const EdgeInsets.only(left: 10, right: 20.0),
                          child: Text(
                            "Register",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                letterSpacing: 1),
                          ),
                        ),
                        padding: EdgeInsets.all(12),
                        color: Theme.of(context).accentColor,
                        onPressed: () {
                          FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text)
                              .then((value) {
                            FirebaseDatabase.instance.reference().child("users/" + value.user.uid).set(
                                {
                                  "username": usernameController.text,
                                  "email": emailController.text,
                                  "uid": value.user.uid,
                                  "imageURL": imageURL,
                                }
                            ).then((value1) {
                              LocalDB.uid = value.user.uid;
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => LoginScreen()),
                              );
                            }).catchError((error) {
                              print("Failed to add. " + error.toString());
                            });
                          }).catchError((error) {
                            print(error.toString());
                          });
                          // if (_formKey.currentState.validate()) {
                          //   Navigator.pushReplacement(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => LoginScreen()));
                          // }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))))
              ],
            )));
  }
}
