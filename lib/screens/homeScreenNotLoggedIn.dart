import 'package:flutter/material.dart';
import 'package:uitest/data/LocalDB.dart';
import 'package:uitest/screens/accountScreen.dart';
import 'package:uitest/screens/communityScreen.dart';
import 'package:uitest/screens/loginScreen.dart';
import 'package:uitest/screens/messagesScreen.dart';
import 'package:uitest/screens/sellScreen.dart';
import '../data/mockData.dart';
import 'package:flutter/rendering.dart';
import '../screens/storeScreen.dart';
import '../screens/searchScreen.dart';
import '../screens/favouritesScreen.dart';
import '../screens/coursesScreen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_permissions/location_permissions.dart';



class HomeScreenNotLoggedIn extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenNotLoggedIn> {
  int _selectedIndex = 0;
  List<Widget> screenList = List<Widget>();

  List<BottomTab> tabs = <BottomTab>[
    BottomTab('Buy', Icons.store, 'Buy'),
    BottomTab('Login', Icons.login, 'Login'),
  ];

  Widget bottomRow(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: (){
            Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => LoginScreen()));
          },
          child: Column(
              children:[
                Icon(Icons.login),
                Text('Login')
              ]
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          top: false,
          child: Column(
            children: [
              Expanded(child: StoreScreen()),
              bottomRow(),
            ],
          ),
    );
  }
}