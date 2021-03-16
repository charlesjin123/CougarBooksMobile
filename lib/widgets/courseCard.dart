import 'package:flutter/material.dart';
import './imageContainer.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final String author;
  final Widget image;
  final bool isFavourited;
  final double completed;

  const CourseCard({
    Key key,
    this.title,
    this.author,
    this.image,
    this.isFavourited,
    this.completed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Theme.of(context).accentColor,
      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 2,
              child: ImageContainer(image: image, height: 80, width: 80)),
          Expanded(
            flex: 5,
            child: Container(
                margin: EdgeInsets.only(top: 10),
                //width: MediaQuery.of(context).size.width * 0.58,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(this.title,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500)),
                    SizedBox(height: 10),
                    Text(
                      '- $author',
                      style:
                          TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                    ),
                    SizedBox(height: 20),
                    completed > 0
                        ? Container(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              height: 2,
                              child: LinearProgressIndicator(
                                value: completed / 100,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme.of(context).primaryColor),
                                backgroundColor: Colors.grey,
                              ),
                            ))
                        : Container()
                  ],
                )),
          ),
          Expanded(
            flex: 2,
            child: Container(
              //margin: EdgeInsets.only(top: 5),
              child: IconButton(
                  icon: Icon(
                      isFavourited ? Icons.favorite : Icons.favorite_border,
                      color: Theme.of(context).primaryColor),
                  onPressed: () {}),
            ),
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}
