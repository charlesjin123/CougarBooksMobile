import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uitest/data/LocalDB.dart';
import 'package:uitest/widgets/item.dart';
import 'package:uitest/widgets/profileProducts.dart';

import '../data/mockData.dart';
import '../widgets/gradientAppBar.dart';
import '../widgets/profileDetail.dart';

// class AccountScreen extends StatelessWidget {
//   final BottomTab tab;
//   const AccountScreen({
//     Key key,
//     this.tab,
//   }) : super(key: key);
//
//   void initState() {
//     Map<String, dynamic> profile = {};
//     // FirebaseDatabase.instance.reference().child("users/" + AuthManager.getuid()).once()
//     FirebaseDatabase.instance.reference().child("users/" + LocalDB.uid).once()
//         .then((datasnapshot) {
//       profile["username"] = datasnapshot.value["username"];
//       profile["email"] =  datasnapshot.value["email"];
//       profile["items"] = new List<Item>();
//       if (datasnapshot.value["products"] != null) {
//         datasnapshot.value["products"].forEach((k, v) {
//           profile["items"].add(Item(v["id"], v["name"], v["price"].toDouble(), v["details"], v["imageURL"], LocalDB.uid));
//         });
//       }
//       LocalDB.profile = profile;
//
//     }).catchError((error) {
//       print("Failed to load data. ");
//       print(error);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: GradientAppBar(title: tab.title, showActions: 'logout'),
//       body: SingleChildScrollView(
//         child: Container(
//           width: double.infinity,
//           margin: EdgeInsets.all(10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Container(
//                 height: 125,
//                 margin: EdgeInsets.only(bottom: 10),
//                 child: Center(
//                   child: CircleAvatar(
//                     backgroundColor: Theme.of(context).accentColor,
//                     radius: 60,
//                     child: CircleAvatar(
//                       backgroundColor: Colors.white,
//                       radius: 58,
//                       child: CircleAvatar(
//                         backgroundImage: NetworkImage(profile['userImage']),
//                         backgroundColor: Colors.black,
//                         radius: 56,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Divider(
//                 color: Theme.of(context).accentColor.withOpacity(0.8),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Text('Profile Details',
//                       style: TextStyle(
//                         fontWeight: FontWeight.w500,
//                         fontSize: 15,
//                       )),
//                   IconButton(
//                       icon: Icon(
//                         Icons.edit,
//                         color: Theme.of(context).accentColor,
//                       ),
//                       onPressed: () {})
//                 ],
//               ),
//               ProfileDetail(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

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
    Map<String, dynamic> profile = {};
    // FirebaseDatabase.instance.reference().child("users/" + AuthManager.getuid()).once()
    FirebaseDatabase.instance.reference().child("users/" + LocalDB.uid).once()
        .then((datasnapshot) {
      profile["username"] = datasnapshot.value["username"];
      profile["email"] =  datasnapshot.value["email"];
      profile["items"] = new List<Item>();
      if (datasnapshot.value["products"] != null) {
        datasnapshot.value["products"].forEach((k, v) {
          profile["items"].add(Item(v["id"], v["name"], v["price"].toDouble(), v["details"], v["imageURL"], LocalDB.uid));
        });
      }
      LocalDB.profile = profile;

      print("Item Length: ${LocalDB.profile["items"].length}");
      print("Items: ${profile["items"]}");

      setState(() {});
    }).catchError((error) {
      print("Failed to load data. ");
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(title: widget.tab.title, showActions: 'logout'),
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
                        backgroundImage: NetworkImage(profile['userImage']),
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
                      onPressed: () {})
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
                ],
              ),
              Expanded(child: ProfileProducts()),
            ],
          ),
        ),
      ),
    );
  }
}
