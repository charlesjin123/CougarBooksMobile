import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
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

  String _eula = "No Data";

  var loading = false;

  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  //var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  File image;

  @override
  initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final _loadedData = await rootBundle.loadString('assets/eula.txt');
    setState(() {
      _eula = _loadedData;
      print(_eula);
    });
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final tempImage = File(image.path);
      setState(() => this.image = tempImage);
    } catch (error) {
      print("Failed to pick image: " + error);
    }
  }

  Widget EULADialog(){
    return AlertDialog(
      title: const Center(child: Text('User Agreement')),
      actions: [
        ElevatedButton(onPressed: onPressedAgree, child: Text("Agree"))
      ],
      content: SingleChildScrollView(
        child: Text(_eula),
      ),
    );
  }

  void onPressedRegister() async {
    if(_formKey.currentState.validate()){
      showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            return EULADialog();
          }
      );
    }
  }

  void onPressedAgree() async {
    loading = true;
    setState(() {});
    Navigator.of(context).pop();

    if (image == null) {
      await showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error: ' + "Profile image cannot be empty.",
                  style: TextStyle(fontSize: 15)),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok', style: TextStyle(fontSize: 15)),
                  onPressed: () {
                    loading = false;
                    setState(() {});
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          }
      );
      return;
    }

    if (usernameController.text == null) {
      await showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error: ' + "Username cannot be empty.",
                  style: TextStyle(fontSize: 15)),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok', style: TextStyle(fontSize: 15)),
                  onPressed: () {
                    loading = false;
                    setState(() {});
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          }
      );
      return;
    }

    // if (phoneController.text == null) {
    //   await showDialog<void>(
    //       context: context,
    //       barrierDismissible: false, // user must tap button!
    //       builder: (BuildContext context) {
    //         return AlertDialog(
    //           title: Text('Error: ' + "Phone Number cannot be empty.",
    //               style: TextStyle(fontSize: 15)),
    //           actions: <Widget>[
    //             FlatButton(
    //               child: Text('Ok', style: TextStyle(fontSize: 15)),
    //               onPressed: () {
    //                 loading = false;
    //                 setState(() {});
    //                 Navigator.of(context).pop();
    //               },
    //             ),
    //           ],
    //         );
    //       }
    //   );
    //   return;
    // }

    FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text)
        .then((value) {
      FirebaseDatabase.instance.reference().child("users/" + value.user.uid).set(
          {
            "username": usernameController.text,
            "email": emailController.text,
            //"phone": phoneController.text,
            "uid": value.user.uid,
          }
      ).then((value1) async {
        LocalDB.uid = value.user.uid;
        var imageURL;
        var fileName = "profile-" + DateTime.now().millisecondsSinceEpoch.toString() + '.png';
        var fileToUpload = image;
        if (fileToUpload != null) {
          FirebaseStorage.instance.ref().child("profiles/" + fileName).putFile(fileToUpload).then((taskEvent) {
            if (taskEvent.state == TaskState.success) {
              FirebaseStorage.instance.ref().child("profiles/" + fileName).getDownloadURL()
                  .then((value) {
                imageURL = value.toString();
                FirebaseDatabase.instance.reference().child("users/" + LocalDB.uid).update(
                    {
                      "imageURL": imageURL,
                    }
                ).then((value1) async {
                  await showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Registered Successfully!",
                              style: TextStyle(fontSize: 15)),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Ok', style: TextStyle(fontSize: 15)),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      }
                  );
                  loading = false;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                }).catchError((error) {
                  print("Failed to add. " + error.toString());
                });
              }).catchError((error) {
                print("Failed to get image URL: " + error.toString());
              });
            }
          }).catchError((error) {
            print("Failed to upload image: " + error.toString());
          });
        } else {
          await showDialog<void>(
              context: context,
              barrierDismissible: false, // user must tap button!
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Error: ' + "Profile image cannot be empty.",
                      style: TextStyle(fontSize: 15)),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Ok', style: TextStyle(fontSize: 15)),
                      onPressed: () {
                        loading = false;
                        setState(() {});
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              }
          );
        }
      }).catchError((error) async {
        await showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              String errorMsg = error.toString().replaceRange(0, error.toString().indexOf("]")+1, "");
              if (errorMsg.contains("Given String is empty or null")) {
                errorMsg = "Fields cannot be empty";
              }
              return AlertDialog(
                title: Text('Error: ' + errorMsg,
                    style: TextStyle(fontSize: 15)),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Ok', style: TextStyle(fontSize: 15)),
                    onPressed: () {
                      loading = false;
                      setState(() {});
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            }
        );
        print("Failed to add. " + error.toString());
      });
    }).catchError((error) async {
      await showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            String errorMsg = error.toString().replaceRange(0, error.toString().indexOf("]")+1, "");
            if (errorMsg.contains("Given String is empty or null")) {
              errorMsg = "Fields cannot be empty";
            }
            return AlertDialog(
              title: Text('Error: ' + errorMsg,
                  style: TextStyle(fontSize: 15)),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok', style: TextStyle(fontSize: 15)),
                  onPressed: () {
                    loading = false;
                    setState(() {});
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          }
      );
      print(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        loading == false ? Form(
            key: _formKey,
            child: Stack(
              children: [
                Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.90,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 200,
                          child: image != null ? Image.file(image) : Image.network("https://complianz.io/wp-content/uploads/2019/03/placeholder-300x202.jpg"),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 150,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    pickImage(ImageSource.camera);
                                    // final cameras = await availableCameras();
                                    // final firstCamera = cameras.first;
                                    // var newURL = await Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(builder: (context) => TakePictureScreen(camera: firstCamera, type: "profile")),
                                    // );
                                    // imageURL = newURL != null ? newURL : imageURL;
                                    // setState(() {});
                                  },
                                  child: Container(
                                    child: Text("Take Profile Picture", style: TextStyle(fontSize: 17), textAlign: TextAlign.center,),
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Container(
                                width: 150,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    pickImage(ImageSource.gallery);
                                  },
                                  child: Container(
                                    child: Text("Choose Profile Picture", style: TextStyle(fontSize: 17), textAlign: TextAlign.center,),
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                  ),
                                ),
                              ),
                            ],
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
                        // InputTextField(
                        //   keyboardType: TextInputType.phone,
                        //   prefixIcon: Icons.phone,
                        //   hint: 'Phone Number',
                        //   validationFunction: (value) {
                        //     if (value.isEmpty) {
                        //       return 'Phone Number is required';
                        //     }
                        //     return null;
                        //   },
                        //   controller: phoneController,
                        // ),
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
                                onPressed: onPressedRegister,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)))),
                      ],
                    )
                ),
                // if (loading)
                //   ModalBarrier(dismissible: false, color: Colors.black),
              ],
            )
        ) : Center(
          child: CircularProgressIndicator(),
        ),
        // if (loading)
        //    SizedBox(
        //      height: double.infinity,
        //      child: Opacity(
        //       opacity: 0.3,
        //       child: ModalBarrier(dismissible: false, color: Colors.black),
        //      ),
        //    ),
        // if (loading)
        //   const Center(
        //     child: CircularProgressIndicator(),
        //   ),
        // if (loading)
        //   CircularProgressIndicator(),
      ],
    );
  }
}