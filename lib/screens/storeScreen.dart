import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uitest/data/LocalDB.dart';

import 'package:uitest/data/mockData.dart';
import 'package:uitest/widgets/gradientAppBar.dart';
import 'package:uitest/widgets/item.dart';
import 'package:uitest/widgets/productBanner.dart';
import '../widgets/headerTitle.dart';
import '../widgets/courseBanner.dart';

class StoreScreen extends StatefulWidget {
  final BottomTab tab;
  const StoreScreen({
    Key key,
    this.tab,
  }) : super(key: key);

  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  List<Item> items;
  List<Item> newArrivals;

  void initState() {
    loadProducts();
  }

  void loadProducts() {
    items = [];
    newArrivals = [];
    LocalDB.items = [];
    FirebaseDatabase.instance.reference().child("users").once()
        .then((datasnapshot) {
      datasnapshot.value.forEach((k, v) {
        if (v["products"] != null) {
          v["products"].forEach((k1,v1) {
            var map = Map<String, dynamic>.from(v1);
            //var user = User(v["uid"], v["username"], v["email"]);
            items.add(Item(map["id"], map["name"], map["price"].toDouble(), map["details"], map["imageURL"], map["uid"], map["timestamp"], map["category"], map["longtitude"], map["latitude"]));
          });
        }
      });
      items.forEach((value) {
        if (value.timestamp != null) {
          LocalDB.items.add(value);
          newArrivals.add(value);
        }
      });
      newArrivals.sort((a, b) {
        return b.timestamp - a.timestamp;
      });
      setState(() {});
    }).catchError((error) {
      print("Failed to load all products. ");
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GradientAppBar(title: widget.tab.title, showActions: "search", homeCallBack: () {} ),
        body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  HeaderTitle(text: 'New Arrivals'),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var tmpProduct = newArrivals[index];
                      return Container(
                          padding: EdgeInsets.only(top: 10, left: 5, right: 5),
                          child: ProductBanner(
                            item: tmpProduct,
                          ));
                    },
                    itemCount: newArrivals.length,
                  ),
                  // Container(
                  //   height: 150,
                  //   margin: EdgeInsets.only(top: 10),
                  //   child: ListView.builder(
                  //     scrollDirection: Axis.horizontal,
                  //     itemBuilder: (context, index) {
                  //       var tmpProduct = newArrivals[index];
                  //       return Container(
                  //           padding: EdgeInsets.only(left: 5, right: 5),
                  //           child: ProductBanner(
                  //             item: tmpProduct,
                  //           ));
                  //     },
                  //     itemCount: newArrivals.length,
                  //   ),
                  // ),
                  //SizedBox(height: 125),
                  // HeaderTitle(text: 'For You'),
                  // Container(
                  //   height: 150,
                  //   margin: EdgeInsets.only(top: 10),
                  //   child: ListView.builder(
                  //     scrollDirection: Axis.horizontal,
                  //     itemBuilder: (context, index) {
                  //       var tmpProduct = items[index];
                  //       return Container(
                  //           padding: EdgeInsets.only(left: 5, right: 5),
                  //           child: ProductBanner(
                  //             item: tmpProduct,
                  //           ));
                  //     },
                  //     itemCount: items.length,
                  //   ),
                  // ),
                  // HeaderTitle(text: 'Top Picks'),
                  // Container(
                  //   height: 150,
                  //   margin: EdgeInsets.only(top: 10),
                  //   child: ListView.builder(
                  //     scrollDirection: Axis.horizontal,
                  //     itemBuilder: (context, index) {
                  //       var tmpProduct = items[index];
                  //       return Container(
                  //           padding: EdgeInsets.only(left: 5, right: 5),
                  //           child: ProductBanner(
                  //             item: tmpProduct,
                  //           ));
                  //     },
                  //     itemCount: items.length,
                  //   ),
                  // ),
                ],
              )),
        ));
  }
}
