import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uitest/data/LocalDB.dart';
import 'package:uitest/screens/PostDetailScreen.dart';
import 'package:uitest/screens/editItemScreen.dart';
import 'package:uitest/screens/editProfileScreen.dart';
import 'package:uitest/screens/searchScreen.dart';
import 'package:uitest/widgets/item.dart';
import 'package:uitest/widgets/post.dart';
import 'package:uitest/widgets/profileProducts.dart';

import '../data/mockData.dart';
import '../widgets/gradientAppBar.dart';
import '../widgets/profileDetail.dart';

class CommunityScreen extends StatefulWidget {
  final BottomTab tab;
  const CommunityScreen({
    Key key,
    this.tab,
  }) : super(key: key);

  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  List<Post> posts;

  void initState() {
    loadPosts();
  }

  void loadPosts() {
    posts = [];
    FirebaseDatabase.instance.reference().child("users").once()
        .then((datasnapshot) {
      datasnapshot.value.forEach((k, v) {
        if (v["posts"] != null) {
          v["posts"].forEach((k1,v1) {
            var map = Map<String, dynamic>.from(v1);
            //var user = User(v["uid"], v["username"], v["email"]);
            if (LocalDB.minPostDist <= getDist(LocalDB.longitude, LocalDB.latitude, map["longitude"], map["latitude"]) &&
                getDist(LocalDB.longitude, LocalDB.latitude, map["longitude"], map["latitude"]) <= LocalDB.maxPostDist) {
              posts.add(Post(map["id"], map["title"], map["details"], map["uid"], map["timestamp"], map["longitude"], map["latitude"]));
            }
          });
        }
      });
      setState(() {});
    }).catchError((error) {
      print("Failed to load all posts. ");
      print(error);
    });
  }

  double getDist(double lon1, double lat1, double lon2, double lat2) {
    lon1 = degreesToRads(lon1);
    lat1 = degreesToRads(lat1);
    lon2 = degreesToRads(lon2);
    lat2 = degreesToRads(lat2);

    double dlon = lon2 - lon1;
    double dlat = lat2 - lat1;
    double a = pow(sin(dlat / 2), 2) + cos(lat1) * cos(lat2) * pow(sin(dlon / 2),2);
    double c = 2 * asin(sqrt(a));
    double r = 3956; // in miles, 6371 for km
    return c * r;
  }

  num degreesToRads(num deg) {
    return (deg * pi) / 180.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(title: "Community", showActions: 'post', homeCallBack: loadPosts),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var tmpPost = posts[index];
                  return ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PostDetailScreen(tmpPost)));
                      },
                      contentPadding: EdgeInsets.all(2),
                      title: Text(tmpPost.title),
                      subtitle: Text(tmpPost.details.length < 60 ? tmpPost.details : tmpPost.details.substring(0, 60)+"..."),
                      // leading: CircleAvatar(
                      //   backgroundImage: NetworkImage(tmpItem.imageUrl),
                      //   backgroundColor: Colors.black,
                      //   radius: 25,
                      // )
                  );
                },
                itemCount: posts.length,
                scrollDirection: Axis.vertical,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


