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

class SellScreen extends StatefulWidget {
  final BottomTab tab;
  const SellScreen({
    Key key,
    this.tab,
  }) : super(key: key);

  @override
  _SellScreenState createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(title: widget.tab == null ? "Sell" : widget.tab.title),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
            ],
          ),
        ),
      ),
    );
  }
}


