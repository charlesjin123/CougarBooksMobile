import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final Widget image;
  double height;
  double width;
  ImageContainer({Key key, this.image, this.height = 75, this.width = 75})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      width: this.width,
      margin: EdgeInsets.all(10),
      child: this.image,
    );
  }
}
