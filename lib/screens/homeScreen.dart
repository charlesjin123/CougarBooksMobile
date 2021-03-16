import 'package:flutter/material.dart';
import 'package:uitest/screens/accountScreen.dart';
import '../data/mockData.dart';
import 'package:flutter/rendering.dart';
import '../screens/storeScreen.dart';
import '../screens/searchScreen.dart';
import '../screens/favouritesScreen.dart';
import '../screens/coursesScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<Widget> screenList = List<Widget>();
  @override
  void initState() {
    allTabs.forEach((BottomTab tab) {
      switch (tab.iconTitle) {
        case 'Store':
          {
            screenList.add(StoreScreen(tab: tab));
            break;
          }
        case 'Profile':
          {
            screenList.add(AccountScreen(tab: tab));
            break;
          }
        // case 'Courses':
        //   {
        //     screenList.add(CoursesScreen(tab: tab));
        //     break;
        //   }
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
          child: IndexedStack(
            index: _selectedIndex,
            children: screenList,
          ),
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
