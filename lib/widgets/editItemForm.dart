import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:uitest/data/LocalDB.dart';
import 'package:uitest/data/mockData.dart';
import 'package:uitest/screens/accountScreen.dart';
import 'package:uitest/screens/loginScreen.dart';
import 'package:uitest/screens/takePictureScreen.dart';
import 'package:uitest/widgets/inputTextField.dart';
import 'package:uitest/widgets/item.dart';
import 'package:http/http.dart' as http;

class EditItemForm extends StatefulWidget {
  Item item;

  EditItemForm({Item item}) {
    this.item = item;
  }

  @override
  _EditItemState createState() => _EditItemState();
}

class _EditItemState extends State<EditItemForm> {
  final _formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var priceController = TextEditingController();
  var detailsController = TextEditingController();

  List<String> _categories = categories;
  List<dynamic> _selectedCategories;

  var imageURL;
  bool imagePicked = false;
  File image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final tempImage = File(image.path);
      imagePicked = true;
      setState(() => this.image = tempImage);
    } catch (error) {
      print("Failed to pick image: " + error);
    }
  }

  Future<File> urlToFile(String imageUrl) async {
// generate random number.
    var rng = new Random();
// get temporary directory of device.
    Directory tempDir = await getTemporaryDirectory();
// get temporary path from temporary directory.
    String tempPath = tempDir.path;
// create a new file in temporary path with random file name.
    File file = new File('$tempPath'+ (rng.nextInt(100)).toString() +'.png');
// call http.get method and pass imageUrl into it to get response.
    http.Response response = await http.get(Uri.parse(imageUrl));
// write bodyBytes received in response to file.
    await file.writeAsBytes(response.bodyBytes);
// now return the file which is created with random name in
// temporary directory and image bytes from response is written to // that file.
    return file;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.item?.name;
    priceController.text = widget.item?.price != null ? widget.item?.price.toString() : "";
    detailsController.text = widget.item?.details;
    imageURL = widget.item?.imageUrl;
    _selectedCategories = widget.item?.category == null ? [] : new List<dynamic>.from(widget.item?.category);
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
                !imagePicked ? Container(
                  height: 200,
                  child: imageURL != null ? Image.network(imageURL) : Image.network("https://complianz.io/wp-content/uploads/2019/03/placeholder-300x202.jpg"),
                ) : Container(
                  height: 200,
                  child: Image.file(image),
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
                          },
                          child: Container(
                            child: Text("Take Item Picture", style: TextStyle(fontSize: 17), textAlign: TextAlign.center,),
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
                            child: Text("Choose Item Picture", style: TextStyle(fontSize: 17), textAlign: TextAlign.center,),
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   width: 250,
                //   child: ElevatedButton(
                //     onPressed: () async {
                //       final cameras = await availableCameras();
                //       final firstCamera = cameras.first;
                //       var newURL = await Navigator.push(
                //         context,
                //         MaterialPageRoute(builder: (context) => TakePictureScreen(camera: firstCamera, type: "product")),
                //       );
                //       imageURL = newURL != null ? newURL : imageURL;
                //       setState(() {});
                //     },
                //     child: Text("Edit Image", style: TextStyle(fontSize: 20)),
                //   ),
                // ),
                InputTextField(
                  keyboardType: TextInputType.text,
                  prefixIcon: Icons.label,
                  hint: 'Book Name',
                  controller: nameController,
                ),
                InputTextField(
                  keyboardType: TextInputType.number,
                  prefixIcon: Icons.attach_money,
                  hint: 'Price',
                  controller: priceController,
                ),
                InputTextField(
                  keyboardType: TextInputType.text,
                  prefixIcon: Icons.description,
                  hint: 'Book Description',
                  controller: detailsController,
                ),
                Text("Ex: Edition, Author, Condition of the book"),
                Container(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Category',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    )),
                SizedBox(height: 10),
                Wrap(
                  children: _categories
                      .map(
                        (e) => Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ActionChip(
                        label: Text(e),
                        onPressed: () {
                          setState(() {
                            _selectedCategories.contains(e)
                                ? _selectedCategories.remove(e)
                                : _selectedCategories.add(e);
                          });
                        },
                        labelStyle: TextStyle(
                            color: _selectedCategories.contains(e)
                                ? Colors.white
                                : Colors.black),
                        padding: EdgeInsets.all(8),
                        backgroundColor: _selectedCategories.contains(e)
                            ? Theme.of(context).accentColor
                            : Colors.grey[300],
                      ),
                    ),
                  )
                      .toList(),
                ),
                widget.item != null ? Container(
                  margin: EdgeInsets.symmetric(vertical: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          //margin: EdgeInsets.all(20),
                          child: FlatButton.icon(
                              icon: Icon(
                                Icons.cancel,
                                color: Colors.white,
                                size: 20,
                              ),
                              label: Padding(
                                padding: const EdgeInsets.only(left: 10, right: 20.0),
                                child: Text(
                                  "Remove",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      letterSpacing: 1),
                                ),
                              ),
                              padding: EdgeInsets.all(12),
                              color: Colors.red,
                              onPressed: deleteItem,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)
                              )
                          )
                      ),
                      SizedBox(width: 20),
                      Container(
                          //margin: EdgeInsets.all(20),
                          child: FlatButton.icon(
                              icon: Icon(
                                Icons.save,
                                color: Colors.white,
                                size: 20,
                              ),
                              label: Padding(
                                padding: const EdgeInsets.only(left: 10, right: 20.0),
                                child: Text(
                                  "Publish",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      letterSpacing: 1),
                                ),
                              ),
                              padding: EdgeInsets.all(12),
                              color: Theme.of(context).accentColor,
                              onPressed: saveItemToAccountPage,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)
                              )
                          )
                      ),
                    ],
                  ),
                ) : Container(
                    margin: EdgeInsets.all(20),
                    child: FlatButton.icon(
                        icon: Icon(
                          Icons.save,
                          color: Colors.white,
                          size: 20,
                        ),
                        label: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 20.0),
                          child: Text(
                            "Publish",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                letterSpacing: 1),
                          ),
                        ),
                        padding: EdgeInsets.all(12),
                        color: Theme.of(context).accentColor,
                        onPressed: () async {
                          try {
                            saveItemToAccountPage();
                          } catch (error) {
                            await showDialog<void>(
                              context: context,
                              barrierDismissible: false, // user must tap button!
                              builder: (BuildContext context) {
                                String errorMsg = "Fields cannot be empty.";
                                if (error.toString().contains("Invalid double")) {
                                  errorMsg = "Invalid price.";
                                }
                                return AlertDialog(
                                  title: Text('Error: ' + errorMsg,
                                      style: TextStyle(fontSize: 15)),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text('Ok', style: TextStyle(fontSize: 15)),
                                      onPressed: () => Navigator.of(context).pop(),
                                    ),
                                  ],
                                );
                              }
                            );
                            print("Error: " + error.toString());
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                        )
                    )
                ),
              ],
            )));
  }

  void deleteItem() {
    String path = widget.item.id;
    FirebaseDatabase.instance.reference().child("users/" + LocalDB.uid + "/products/item" + path).remove().then((value1) {
      Navigator.pop(context);
    }).catchError((error) {
      print("Failed to remove. " + error.toString());
    });
  }

  void saveItemToAccountPage() {
    var timestamp = new DateTime.now().millisecondsSinceEpoch;
    String path = timestamp.toString();
    if (widget.item != null) {
      path = widget.item.id;
    }
    FirebaseDatabase.instance.reference().child("users/" + LocalDB.uid + "/products/item" + path).update(
        {
          "name": nameController.text,
          "price": double.parse(priceController.text),
          "details": detailsController.text,
          "id": path,
          "uid": LocalDB.uid,
          "timestamp": DateTime.now().millisecondsSinceEpoch,
          "category": _selectedCategories,
          "longitude": LocalDB.longitude,
          "latitude": LocalDB.latitude,
        }
    ).then((value1) async {
      var fileName = "product-" + DateTime.now().millisecondsSinceEpoch.toString() + '.png';
      var fileToUpload = image;
      if (fileToUpload != null) {
        FirebaseStorage.instance.ref().child("products/"+LocalDB.uid+"/" + fileName).putFile(fileToUpload).then((taskEvent) {
          if (taskEvent.state == TaskState.success) {
            FirebaseStorage.instance.ref().child("products/"+LocalDB.uid+"/" + fileName).getDownloadURL()
                .then((value) {
              imageURL = value.toString();
              FirebaseDatabase.instance.reference().child("users/" + LocalDB.uid + "/products/item" + path).update(
                  {
                    "imageURL": imageURL,
                  }
              ).then((value1) async {
                await showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Item saved successfully!",
                            style: TextStyle(fontSize: 15)),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Ok', style: TextStyle(fontSize: 15)),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      );
                    }
                );
                Navigator.pop(context);
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
      } else if (imageURL != null) {
        await showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Item saved successfully!",
                  style: TextStyle(fontSize: 15)),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok', style: TextStyle(fontSize: 15)),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          }
        );
        Navigator.pop(context);
      } else {
        await showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error: ' + "Product image cannot be empty.",
                  style: TextStyle(fontSize: 15)),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok', style: TextStyle(fontSize: 15)),
                  onPressed: () => Navigator.of(context).pop(),
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
                  onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        }
      );
      print("Failed to add. " + error.toString());
    });
  }
}




