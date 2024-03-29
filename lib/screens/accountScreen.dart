import 'package:firebase_auth/firebase_auth.dart';
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
import 'homeScreenNotLoggedIn.dart';

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

  }


  // Show AlertDialog
  showAlertDialog(BuildContext context) {
    // Init
    AlertDialog dialog = AlertDialog(
      title: Text("Delete Your Account?"),
      content: Text("You are about to permanently delete your account. This can not be undone. Do you want to delete your account?"),
      actions: [
        ElevatedButton(
            child: Text("Confirm"),
            onPressed: () {

              FirebaseAuth.instance.currentUser.delete().then(
                  (value) =>Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => HomeScreenNotLoggedIn()),
                          (Route<dynamic> route) => false)
              );


            }
        ),
        ElevatedButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.pop(context);
            }
        ),
      ],
    );

    // Show the dialog
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(title: widget.tab == null ? "Profile" : widget.tab.title, showActions: 'logout'),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
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

                    // SizedBox(
                    //   height: 15,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: <Widget>[
                    //     Text('Your Products',
                    //         style: TextStyle(
                    //           fontWeight: FontWeight.w500,
                    //           fontSize: 15,
                    //         )),
                    //     IconButton(
                    //         icon: Icon(
                    //           Icons.add,
                    //           color: Theme.of(context).accentColor,
                    //         ),
                    //         onPressed: () async {
                    //           await Navigator.push(
                    //             context,
                    //             MaterialPageRoute(builder: (context) => EditItemScreen()),
                    //           );
                    //           initState();
                    //         })
                    //   ],
                    // ),
                    // Container(
                    //     child: ListView.builder(
                    //         shrinkWrap: true,
                    //         physics: NeverScrollableScrollPhysics(),
                    //         itemCount: LocalDB.profile != null ? LocalDB.profile["items"].length : 0,
                    //         itemBuilder: (BuildContext context, int index) {
                    //           return ListTile(
                    //             onTap: () async {
                    //               await Navigator.push(
                    //                 context,
                    //                 MaterialPageRoute(builder: (context) => EditItemScreen(item: LocalDB.profile["items"][index])),
                    //               );
                    //               initState();
                    //             },
                    //             title: Column(
                    //               children: <Widget>[
                    //                 ProfileProduct(
                    //                   image: Image(image: NetworkImage(LocalDB.profile["items"][index].imageUrl == null ? "https://complianz.io/wp-content/uploads/2019/03/placeholder-300x202.jpg" : LocalDB.profile["items"][index].imageUrl)),
                    //                   name: LocalDB.profile == null ? "" : LocalDB.profile["items"][index].name,
                    //                   price: LocalDB.profile == null ? "" : LocalDB.profile["items"][index].price.toString(),
                    //                 ),
                    //
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
          ),
          Center(
            child: ElevatedButton(onPressed: (){showAlertDialog(context);}, child: Text('Delete Profile')),
          )
        ],
      ),
    );
  }
}


