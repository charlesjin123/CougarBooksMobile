import 'package:flutter/material.dart';

import 'package:uitest/data/mockData.dart';
import 'package:uitest/screens/CourseDetailScreen.dart';
import 'package:uitest/screens/ItemDetailScreen.dart';
import 'package:uitest/widgets/item.dart';

class ProductBanner extends StatelessWidget {
  final Item item;
  const ProductBanner({
    Key key,
    this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ItemDetailScreen(item)));
            },
            child: Container(
              width: 150,
              height: 100,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  //color: Theme.of(context).primaryColor,
                  image: DecorationImage(
                      image: NetworkImage(item.imageUrl),
                      fit: BoxFit.cover)),
            ),
          ),
          SizedBox(height: 2),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Text(
                "\$" + item.price.toString() + "  " + item.name,
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
            ),
          )
        ],
      ),
    );
  }
}
