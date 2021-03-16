import 'package:flutter/material.dart';
import 'package:uitest/widgets/imageContainer.dart';

class FavouritesCard extends StatelessWidget {
  final String title;
  final String author;
  final Widget image;
  const FavouritesCard({
    Key key,
    this.title,
    this.author,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: ImageContainer(image: image),
          flex: 3,
        ),
        Expanded(
          flex: 6,
          child: Container(
              margin: EdgeInsets.only(top: 10),
              //width: MediaQuery.of(context).size.width * 0.60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(this.title,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                  SizedBox(height: 10),
                  Text(
                    '- $author',
                    style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                  )
                ],
              )),
        ),
        Expanded(
          flex: 2,
          child: Container(
            //margin: EdgeInsets.only(top: 5),
            child: IconButton(
                icon: Icon(Icons.delete, color: Theme.of(context).primaryColor),
                onPressed: () {}),
          ),
        )
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}
