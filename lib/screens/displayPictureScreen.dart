import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uitest/data/LocalDB.dart';

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  final String type;

  const DisplayPictureScreen({Key key, this.imagePath, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Camera')),
        // The image is stored as a file on the device. Use the `Image.file`
        // constructor with the given path to display the image.
        body: Container (
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.7,
                child: Image.file(
                  File(imagePath),
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
                width: MediaQuery.of(context).size.width * 0.6,
                child: ElevatedButton(
                  onPressed: () {
                    var fileToUpload = File(imagePath);
                    if (type == "product") {
                      var fileName = "product-" + DateTime.now().millisecondsSinceEpoch.toString() + '.png';
                      FirebaseStorage.instance.ref().child("products/"+LocalDB.uid+"/" + fileName).putFile(fileToUpload).then((taskEvent) {
                        if (taskEvent.state == TaskState.success) {
                          FirebaseStorage.instance.ref().child("products/"+LocalDB.uid+"/" + fileName).getDownloadURL()
                              .then((value) {
                            Navigator.pop(context, value.toString());
                          }).catchError((error) {
                            print("Failed to get the URL");
                          });
                        }
                      });
                    } else if (type == "profile") {
                      var fileName = "profile-" + DateTime.now().millisecondsSinceEpoch.toString() + '.png';
                      FirebaseStorage.instance.ref().child("profiles/" + fileName).putFile(fileToUpload).then((taskEvent) {
                        if (taskEvent.state == TaskState.success) {
                          FirebaseStorage.instance.ref().child("profiles/" + fileName).getDownloadURL()
                              .then((value) {
                            Navigator.pop(context, value.toString());
                          }).catchError((error) {
                            print("Failed to get the URL");
                          });
                        }
                      });
                    }
                  },
                  child: Text("Upload Image", style: TextStyle(fontSize: 20)),
                ),
              ),
            ],
          ),
        )
    );
  }
}