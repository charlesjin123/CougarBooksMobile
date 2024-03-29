
import 'package:flutter/material.dart';
import 'package:uitest/widgets/editItemForm.dart';
import 'package:uitest/widgets/gradientAppBar.dart';
import 'package:uitest/widgets/item.dart';

class EditItemScreen extends StatelessWidget {

  Item item;

  EditItemScreen({Item item}) {
    this.item = item;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //resizeToAvoidBottomPadding: false,
        appBar: GradientAppBar(title: 'Edit Item Page'),
        body: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.only(top: 20),
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
                  EditItemForm(item: this.item,),
                ],
              ),
            ),
          ),
        ));
  }
}
