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
    'Category 1',
    'Category 2',
    'Category 3',
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
                        MaterialPageRoute(builder: (context) => TakePictureScreen(camera: firstCamera)),
                      );
                      imageURL = newURL != null ? newURL : imageURL;
                      setState(() {

                      });
                    },
                    child: Text("Add Image", style: TextStyle(fontSize: 20)),
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
                            borderRadius: BorderRadius.circular(5))))
              ],
            )));
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


class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({
    Key key,
    @required this.camera,
  }) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Take a picture')),
      // Wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner
      // until the controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Construct the path where the image should be saved using the
            // pattern package.
            final path = join(
              // Store the picture in the temp directory.
              // Find the temp directory using the `path_provider` plugin.
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png',
            );

            // Attempt to take a picture and log where it's been saved.
            await _controller.takePicture(path);

            // If the picture was taken, display it on a new screen.
            String imageURL = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(imagePath: path),
              ),
            );
            Navigator.pop(context, imageURL);
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Display the Picture')),
        // The image is stored as a file on the device. Use the `Image.file`
        // constructor with the given path to display the image.
        body: Column(
          children: [
            Image.file(File(imagePath)),
            Container(
              width: 250,
              child: ElevatedButton(
                onPressed: () {
                  var fileToUpload = File(imagePath);
                  var fileName = "product-" + DateTime.now().millisecondsSinceEpoch.toString() + '.png';
                  FirebaseStorage.instance.ref().child("products/"+LocalDB.uid+"/" + fileName).putFile(fileToUpload).events.listen((event) {
                    if (event.type == StorageTaskEventType.success) {
                      FirebaseStorage.instance.ref().child("products/"+LocalDB.uid+"/" + fileName).getDownloadURL()
                          .then((value) {
                        Navigator.pop(context, value.toString());
                      }).catchError((error) {
                        print("Failed to get the URL");
                      });
                    }
                  });
                },
                child: Text("Upload Image", style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        )
    );
  }
}
