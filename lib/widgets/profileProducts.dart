import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uitest/data/LocalDB.dart';
import 'package:uitest/widgets/item.dart';
import '../data/mockData.dart';

class ProfileProducts extends StatefulWidget {

  @override
  _ProfileProductsState createState() => _ProfileProductsState();
}

class _ProfileProductsState extends State<ProfileProducts> {
  @override
  Widget build(BuildContext context) {
    print("LocalDB profile items in profileProducts: ${LocalDB.profile["items"][0].name}");
    return Container(
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: LocalDB.profile["items"].length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Column(
                children: <Widget>[
                  ProfileProduct(
                      image: Image(image: NetworkImage(LocalDB.profile["items"][index].imageUrl)),
                      name: LocalDB.profile == null ? "" : LocalDB.profile["items"][index].name,
                    price: LocalDB.profile == null ? "" : LocalDB.profile["items"][index].price.toString(),
                  ),

                  Divider(
                    color: Theme
                        .of(context)
                        .accentColor
                        .withOpacity(0.8),
                  ),
                ],
              ),
            );
          }));
  }
}

class ProfileProduct extends StatefulWidget {
  final String name;
  final String price;
  final Image image;

  const ProfileProduct({
    Key key,
    @required this.name,
    @required this.price,
    @required this.image,
  }) : super(key: key);

  @override
  _ProfileProductState createState() => _ProfileProductState();
}

class _ProfileProductState extends State<ProfileProduct> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 75,
          height: 75,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
            child: widget.image,
          ),
        ),
        Text(widget.name, style: TextStyle(fontSize: 15)),
        Text(widget.price, style: TextStyle(fontSize: 15)),
      ],
    );
  }
}
