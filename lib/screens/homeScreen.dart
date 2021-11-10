import 'package:flutter/material.dart';
import 'package:uitest/data/LocalDB.dart';
import 'package:uitest/screens/accountScreen.dart';
import 'package:uitest/screens/communityScreen.dart';
import 'package:uitest/screens/messagesScreen.dart';
import '../data/mockData.dart';
import 'package:flutter/rendering.dart';
import '../screens/storeScreen.dart';
import '../screens/searchScreen.dart';
import '../screens/favouritesScreen.dart';
import '../screens/coursesScreen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_permissions/location_permissions.dart';



class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<Widget> screenList = List<Widget>();

  _HomeScreenState() {
    // final Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;
    // geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value) {
    //   LocalDB.longitude = value.longitude;
    //   LocalDB.latitude = value.latitude;
    //   // print(value.latitude);
    //   // print(value.longitude);
    //   // print("Location updated");
    // }).catchError((e) {
    //   print("Failed to get location");
    //   print(e.toString());
    // });
  }

  @override
  void initState() {
    allTabs.forEach((BottomTab tab) {
      switch (tab.iconTitle) {
        case 'Store':
          {
            screenList.add(StoreScreen(tab: tab));
            break;
          }
        case 'Messages':
          {
            screenList.add(MessagesScreen(tab: tab));
            break;
          }
        case 'Profile':
          {
            screenList.add(AccountScreen(tab: tab));
            break;
          }
        // case 'Favourites':
        //   {
        //     screenList.add(FavouritesScreen(tab: tab));
        //     break;
        //   }
        default:
          break;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          top: false,
          child: Center(
            child: screenList.elementAt(_selectedIndex),
          ),
          // child: IndexedStack(
          //   index: _selectedIndex,
          //   children: screenList,
          // ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: allTabs
              .map((e) => BottomNavigationBarItem(
                    icon: Icon(e.icon),
                    title: Text(e.iconTitle),
                  ))
              .toList(),
          currentIndex: _selectedIndex,
          selectedItemColor: Theme.of(context).primaryColor,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          unselectedItemColor: Colors.grey[600],
          unselectedLabelStyle:
              TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500),
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
        ));
  }
}
