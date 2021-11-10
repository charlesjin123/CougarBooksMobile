import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uitest/data/LocalDB.dart';
import 'package:uitest/screens/editItemScreen.dart';
import 'package:uitest/screens/editPostScreen.dart';
import 'package:uitest/screens/editProfileScreen.dart';
import 'package:uitest/widgets/item.dart';
import 'package:uitest/widgets/post.dart';
import 'package:uitest/widgets/profileProducts.dart';

import '../data/mockData.dart';
import '../widgets/gradientAppBar.dart';
import '../widgets/profileDetail.dart';

class AccountScreen extends StatefulWidget {
  final BottomTab tab;
  const AccountScreen({
    Key key,
    this.tab,
  }) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  void initState() {
    print("refreshing account screen.");
    Map<String, dynamic> profile = {};
    // FirebaseDatabase.instance.reference().child("users/" + AuthManager.getuid()).once()
    FirebaseDatabase.instance.reference().child("users/" + LocalDB.uid).once()
        .then((datasnapshot) {
      profile["username"] = datasnapshot.value["username"];
      profile["email"] =  datasnapshot.value["email"];
      profile["imageURL"] =  datasnapshot.value["imageURL"];
      profile["items"] = new List<Item>();
      if (datasnapshot.value["products"] != null) {
        datasnapshot.value["products"].forEach((k, v) {
          profile["items"].add(Item(v["id"], v["name"], v["price"].toDouble(), v["details"], v["imageURL"], LocalDB.uid, v["timestamp"], v["category"], v["longtitude"], v["latitude"]));
        });
      }
      // profile["posts"] = new List<Post>();
      // if (datasnapshot.value["posts"] != null) {
      //   datasnapshot.value["posts"].forEach((k, v) {
      //     profile["posts"].add(Post(v["id"], v["title"], v["details"], LocalDB.uid, v["timestamp"], v["longtitude"], v["latitude"]));
      //   });
      // }
      LocalDB.profile = profile;

      // print("Item Length: ${LocalDB.profile["items"].length}");
      // print("Items: ${profile["items"]}");

      setState(() {});
    }).catchError((error) {
      print("Failed to load user data at account screen. ");
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(title: widget.tab == null ? "Profile" : widget.tab.title, showActions: 'logout'),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 125,
                margin: EdgeInsets.only(bottom: 10),
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).accentColor,
                    radius: 60,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 58,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(LocalDB.profile != null && LocalDB.profile["imageURL"] != null ? LocalDB.profile['imageURL'] : profile["userImage"]),
                        backgroundColor: Colors.black,
                        radius: 56,
                      ),
                    ),
                  ),
                ),
              ),
              Divider(
                color: Theme.of(context).accentColor.withOpacity(0.8),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Profile Details',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      )),
                  IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Theme.of(context).accentColor,
                      ),
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditProfileScreen()),
                        );
                        initState();
                      },)
                ],
              ),
              ProfileDetail(),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Your Products',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      )),
                  IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Theme.of(context).accentColor,
                      ),
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditItemScreen()),
                        );
                        initState();
                      })
                ],
              ),
              Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: LocalDB.profile != null ? LocalDB.profile["items"].length : 0,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EditItemScreen(item: LocalDB.profile["items"][index])),
                            );
                            initState();
                          },
                          title: Column(
                            children: <Widget>[
                              ProfileProduct(
                                image: Image(image: NetworkImage(LocalDB.profile["items"][index].imageUrl == null ? "https://complianz.io/wp-content/uploads/2019/03/placeholder-300x202.jpg" : LocalDB.profile["items"][index].imageUrl)),
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
                      }
                  )
              ),
              // SizedBox(
              //   height: 15,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: <Widget>[
              //     Text('Your Posts',
              //         style: TextStyle(
              //           fontWeight: FontWeight.w500,
              //           fontSize: 15,
              //         )),
              //   ],
              // ),
              // Container(
              //     child: ListView.builder(
              //         shrinkWrap: true,
              //         physics: NeverScrollableScrollPhysics(),
              //         itemCount: LocalDB.profile != null ? LocalDB.profile["posts"].length : 0,
              //         itemBuilder: (BuildContext context, int index) {
              //           return ListTile(
              //             onTap: () async {
              //               await Navigator.push(
              //                 context,
              //                 MaterialPageRoute(builder: (context) => EditPostScreen(post: LocalDB.profile["posts"][index])),
              //               );
              //               initState();
              //             },
              //             title: Column(
              //               children: <Widget>[
              //                 Column(
              //                   children: <Widget>[
              //                     Text(LocalDB.profile["posts"][index].title, style: TextStyle(fontSize: 15)),
              //                     Text(LocalDB.profile["posts"][index].details, style: TextStyle(fontSize: 15)),
              //                   ],
              //                 ),
              //                 Divider(
              //                   color: Theme
              //                       .of(context)
              //                       .accentColor
              //                       .withOpacity(0.8),
              //                 ),
              //               ],
              //             ),
              //           );
              //         }
              //     )
              // ),
            ],
          ),
        ),
      ),
    );
  }
}


