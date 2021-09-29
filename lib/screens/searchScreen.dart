import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:uitest/data/LocalDB.dart';
import 'package:uitest/data/mockData.dart';
import 'package:uitest/widgets/coverImage.dart';
import 'package:uitest/widgets/gradientAppBar.dart';
import 'package:uitest/widgets/inputTextField.dart';
import 'package:uitest/widgets/item.dart';
import 'package:uitest/widgets/searchResults.dart';
import 'dart:math';


class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool loading = false;
  List<Item> searchResults = [];
  var searchController = new TextEditingController();

  void filterProducts() {
    searchResults = [];
    for (Item item in LocalDB.items) {
      if (item.name.toLowerCase().contains(searchController.text.toLowerCase())) {
        searchResults.add(item);
      }
    }

    List<Item> res = [];
    for (Item item in searchResults) {
      if (LocalDB.min <= item.price && item.price <= LocalDB.max
          // && LocalDB.minDist <= getDist(LocalDB.longitude, LocalDB.latitude, item.longitude, item.latitude) &&
          // getDist(LocalDB.longitude, LocalDB.latitude, item.longitude, item.latitude) <= LocalDB.maxDist
      ) {
        if (LocalDB.selectedCategories.isEmpty) {
          res.add(item);
          continue;
        }
        bool valid = true;
        for (String category in LocalDB.selectedCategories) {
          if (!item.category.contains(category)) {
            valid = false;
            break;
          }
        }
        if (valid) {
          res.add(item);
        }
      }
    }
    setState(() {
      searchResults = res;
    });
  }

  // double getDist(double lon1, double lat1, double lon2, double lat2) {
  //   lon1 = degreesToRads(lon1);
  //   lat1 = degreesToRads(lat1);
  //   lon2 = degreesToRads(lon2);
  //   lat2 = degreesToRads(lat2);
  //
  //   double dlon = lon2 - lon1;
  //   double dlat = lat2 - lat1;
  //   double a = pow(sin(dlat / 2), 2) + cos(lat1) * cos(lat2) * pow(sin(dlon / 2),2);
  //   double c = 2 * asin(sqrt(a));
  //   double r = 3956; // in miles, 6371 for km
  //   return c * r;
  // }
  //
  // num degreesToRads(num deg) {
  //   return (deg * pi) / 180.0;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: 'Search',
        showActions: searchResults.length > 0 ? 'filter' : '',
        homeCallBack: filterProducts,
      ),
      body: Container(
          margin: EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width * 0.90,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    flex: 8,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: InputTextField(
                        keyboardType: TextInputType.text,
                        prefixIcon: Icons.search,
                        hint: 'Search ...',
                        controller: searchController,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        List<Item> res = await Future.delayed(
                            Duration(seconds: 2), () {
                          List<Item> results = <Item>[];
                          for (Item item in LocalDB.items) {
                            if (item.name.toLowerCase().contains(searchController.text.toLowerCase())) {
                              results.add(item);
                            }
                          }
                          return results;
                        });
                        // for (Item item in LocalDB.items) {
                        //   if (item.name.toLowerCase().contains(searchController.text.toLowerCase())) {
                        //     searchResults.add(item);
                        //   }
                        // }
                        setState(() {
                          loading = false;
                          searchResults = res;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 18.0, bottom: 15.0),
                        child: Text(
                          "OK",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              loading
                  ? Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                      ),
                    )
                  : Expanded(
                      child: SearchResults(searchResults: searchResults),
                    ),
            ],
          )),
    );
  }
}
