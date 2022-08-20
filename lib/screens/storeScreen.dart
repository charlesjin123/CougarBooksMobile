import 'package:firebase_auth/firebase_auth.dart';
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
  bool loading;
  List<Item> items;

  @override
  void initState() {
    super.initState();
    loading = true;
    initializeProfile();
  }

  void initializeProfile() {
    //print("refreshing account screen.");
    print(FirebaseAuth.instance.currentUser);
    if(FirebaseAuth.instance.currentUser == null){
      loadProducts();
      return;
    }

    Map<String, dynamic> profile = {};
    // FirebaseDatabase.instance.reference().child("users/" + AuthManager.getuid()).once()
    FirebaseDatabase.instance.reference().child("users/" + LocalDB.uid).once()
        .then((datasnapshot) {

          print('logged in');

      profile["username"] = datasnapshot.value["username"];
      profile["email"] =  datasnapshot.value["email"];
      profile["imageURL"] =  datasnapshot.value["imageURL"];
      profile["items"] = new List<Item>();
      if (datasnapshot.value["products"] != null) {
        datasnapshot.value["products"].forEach((k, v) {
          print(v);
          print('making item');
          print(v);
          Item item = Item(v["id"], v["name"], double.parse(v["price"]), v["details"], v["imageURL"], v["uid"], v["timestamp"], [], v["longtitude"], v["latitude"]);
          print("item $item");
          profile["items"].add(Item(v["id"], v["name"], double.parse(v["price"]), v["details"], v["imageURL"], v["uid"], v["timestamp"], [], v["longtitude"], v["latitude"]));
        });
      }
      // if (datasnapshot.value["blockedPosts"] != null) {
      //   profile["blockedPosts"] = datasnapshot.value["blockedPosts"];
      // } else {
      //   profile["blockedPosts"] = {};
      // }
      // if (datasnapshot.value["blockedUsers"] != null) {
      //   profile["blockedUsers"] = datasnapshot.value["blockedUsers"];
      // } else {
      //   profile["blockedUsers"] = {};
      // }
      // profile["posts"] = new List<Post>();
      // if (datasnapshot.value["posts"] != null) {
      //   datasnapshot.value["posts"].forEach((k, v) {
      //     profile["posts"].add(Post(v["id"], v["title"], v["details"], LocalDB.uid, v["timestamp"], v["longtitude"], v["latitude"]));
      //   });
      // }
      LocalDB.profile = profile;

      // print("Item Length: ${LocalDB.profile["items"].length}");
      // print("Items: ${profile["items"]}");

      //loadProducts();
      updateBlocked();

      //setState(() {});

    }).catchError((error) {
      print("Failed to load user data at account screen. ");
      print("length ${LocalDB.newArrivals.length}");
      print(error);
    });
  }

  Future<void> loadProductsLoggedIn() async {
    items = [];
    LocalDB.newArrivals = [];
    LocalDB.items = [];

    print('loadProducts loggedin');
    print(LocalDB.profile["blockedPosts"]);
    print(LocalDB.profile["blockedUsers"]);

    FirebaseDatabase.instance.reference().child("users").once()
        .then((datasnapshot) {
      print('datasnapshot');

      print('datasnapshot foreach');
      datasnapshot.value.forEach((k, v) {
        print('key $k');
        if (v["products"] != null) {
          v["products"].forEach((k1,v1) {
            print('products foreach');
            var map = Map<String, dynamic>.from(v1);

            try{

              print('try missing uid');
              if(v1["uid"] == null){
                throw new Exception('missing uid');
              }

              String name = v1["name"];
              double price = double.parse('${v1["price"]}');
              String imageUrl = v1["imageURL"];
              String id = v1["id"];
              String details = v1["details"];
              String uid = v1["uid"];
              int timestamp = v1["timestamp"];
              List<dynamic> category = v1["category"];
              var longitude = v1["longtitude"];
              var latitude = v1["latitude"];

              Item item = Item(id, name, price, details, imageUrl, uid, timestamp, category, longitude, latitude);
              LocalDB.items.add(item);
              items.add(item);
            }
            catch(e){
              print(v1["uid"]);
              print(v1["id"]);
              print("Invalid Item");
              // print(e);
            }

          });
        }
      });

      print('items.forEach');

      items.forEach((value) {
        if (value.timestamp != null) {
          if(LocalDB.profile == null){
            LocalDB.items.add(value);
            LocalDB.newArrivals.add(value);
          }
          else if (LocalDB.profile["blockedPosts"].keys.contains(value.id)) {
            print("blocked post ${value.id}");
          } else if (LocalDB.profile["blockedUsers"].keys.contains(value.uid)) {
            print("blocked user ${value.uid}");
          } else {
            LocalDB.items.add(value);
            LocalDB.newArrivals.add(value);
          }
        }
      });
      LocalDB.newArrivals.sort((a, b) {
        return b.timestamp - a.timestamp;
      });

      setState(() {
        LocalDB.updateBlockedStoreScreen = false;
        loading = false;
      });

    }).catchError((error) {
      print("Failed to load all products. ");
      print(error);
    });
  }

  Future<void> loadProducts() async {
    items = [];
    LocalDB.newArrivals = [];
    LocalDB.items = [];

    print('loadProducts');

    FirebaseDatabase.instance.reference().child("users").once()
        .then((datasnapshot) {
      print('datasnapshot');

      print('datasnapshot foreach');
      datasnapshot.value.forEach((k, v) {
        print('key $k');
        if (v["products"] != null) {
          v["products"].forEach((k1,v1) {
            print('products foreach');
            var map = Map<String, dynamic>.from(v1);
            //var user = User(v["uid"], v["username"], v["email"]);

            // print(v1);
            // print(v1.keys);

            try{

              if(v1["uid"] == null){
                throw new Exception('missing uid');
              }

              String name = v1["name"];
              print(name);
              double price = double.parse('${v1["price"]}');
              print(price);
              String imageUrl = v1["imageURL"];
              String id = v1["id"];
              String details = v1["details"];
              String uid = v1["uid"];
              int timestamp = v1["timestamp"];
              List<dynamic> category = v1["category"];
              var longitude = v1["longtitude"];
              var latitude = v1["latitude"];

              Item item = Item(id, name, price, details, imageUrl, uid, timestamp, category, longitude, latitude);
              // print("item $item");
              LocalDB.items.add(item);
              items.add(item);
              // print("Valid Item");
            }
            catch(e){
              print(v1["uid"]);
              print(v1["id"]);
              print("Invalid Item");
              // print(e);
            }

            // items.add(Item(map["id"], map["name"], map["price"].toDouble(), map["details"], map["imageURL"], map["uid"], map["timestamp"], map["category"], map["longtitude"], map["latitude"]));
          });
        }
      });
      items.forEach((value) {
        if (value.timestamp != null) {
          if(FirebaseAuth.instance.currentUser != null){
            LocalDB.items.add(value);
            LocalDB.newArrivals.add(value);

          }
          else if(LocalDB.profile == null){
            LocalDB.items.add(value);
            LocalDB.newArrivals.add(value);

          }
          else if (LocalDB.profile["blockedPosts"].keys.contains(value.id)) {
            //print("blocked post ${value.id}");
          } else if (LocalDB.profile["blockedUsers"].keys.contains(value.uid)) {
            //print("blocked user ${value.uid}");
          } else {
            LocalDB.items.add(value);
            LocalDB.newArrivals.add(value);
          }
        }
      });
      LocalDB.newArrivals.sort((a, b) {
        return b.timestamp - a.timestamp;
      });

      setState(() {
        LocalDB.updateBlockedStoreScreen = false;
        loading = false;
      });

    }).catchError((error) {
      print("Failed to load all products. ");
      print(error);
    });
  }


  void updateBlocked() {
    loading = true;
    FirebaseDatabase.instance.reference().child("users/" + LocalDB.uid).once()
        .then((datasnapshot) {
      if (datasnapshot.value["blockedPosts"] != null) {
        LocalDB.profile["blockedPosts"] = datasnapshot.value["blockedPosts"];
      } else {
        LocalDB.profile["blockedPosts"] = {};
      }
      if (datasnapshot.value["blockedUsers"] != null) {
        LocalDB.profile["blockedUsers"] = datasnapshot.value["blockedUsers"];
      } else {
        LocalDB.profile["blockedUsers"] = {};
      }

      loadProductsLoggedIn();

    }).catchError((error) {
      print("Failed to load user data at account screen. ");
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GradientAppBar(title: "Store", showActions: "search", homeCallBack: () {} ),
        body: loading
            ? Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            strokeWidth: 3,
          ),
        )
            :
        SingleChildScrollView(
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
                      var tmpProduct = LocalDB.newArrivals[index];
                      return Container(
                          padding: EdgeInsets.only(top: 10, left: 5, right: 5),
                          child: ProductBanner(
                            item: tmpProduct,
                          ));
                    },
                    itemCount: LocalDB.newArrivals.length,
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
