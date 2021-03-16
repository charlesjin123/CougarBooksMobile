import 'dart:io';

import 'package:flutter/material.dart';

class CoverImage extends StatelessWidget {
  final String imageUrl;
  const CoverImage({
    Key key,
    @required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl.startsWith("http")) {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
      );
    } else if (imageUrl.startsWith("asset")) {
      return Image.asset(
        imageUrl,
        fit: BoxFit.cover,
      );
    }
    return Image.file(
      File(imageUrl),
      fit: BoxFit.cover,
    );
  }
}
