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
import 'package:uitest/screens/takePictureScreen.dart';
import 'package:uitest/widgets/inputTextField.dart';
import 'package:uitest/widgets/item.dart';

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
  var imageURL;

  List<String> _categories = [
    'English',
    'History',
    'Psychology',
    'Economics',
    'Computer Science',
    'Physics',
    'Biology',
    'Chemistry',
    'Math',
    'Statistics',
    'Geometry',
    'Calculus',
    'Linear Algebra',
  ];
  List<dynamic> _selectedCategories;

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
                        MaterialPageRoute(builder: (context) => TakePictureScreen(camera: firstCamera, type: "product")),
                      );
                      imageURL = newURL != null ? newURL : imageURL;
                      setState(() {});
                    },
                    child: Text("Edit Image", style: TextStyle(fontSize: 20)),
                  ),
                ),
                InputTextField(
                  keyboardType: TextInputType.text,
                  prefixIcon: Icons.label,
                  hint: 'Product Name',
                  controller: nameController,
                ),
                InputTextField(
                  keyboardType: TextInputType.number,
                  prefixIcon: Icons.money,
                  hint: 'Price',
                  controller: priceController,
                ),
                InputTextField(
                  keyboardType: TextInputType.text,
                  prefixIcon: Icons.description,
                  hint: 'Product Description',
                  controller: detailsController,
                ),
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
                        onPressed: saveItemToAccountPage,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                        )
                    )
                ),
                widget.item != null ? Container(
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
                      color: Theme.of(context).accentColor,
                      onPressed: deleteItem,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)
                      )
                    )
                ) : Text(""),
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
    FirebaseDatabase.instance.reference().child("users/" + LocalDB.uid + "/products/item" + path).set(
        {
          "name": nameController.text,
          "price": double.parse(priceController.text),
          "details": detailsController.text,
          "imageURL": imageURL,
          "id": path,
          "uid": LocalDB.uid,
          "timestamp": DateTime.now().millisecondsSinceEpoch,
          "category": _selectedCategories,
          "longitude": LocalDB.longitude,
          "latitude": LocalDB.latitude,
        }
    ).then((value1) {
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => AccountScreen()),
      // );
      Navigator.pop(context);
    }).catchError((error) {
      print("Failed to add. " + error.toString());
    });
  }
}




