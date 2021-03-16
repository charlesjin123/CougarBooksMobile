import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:uitest/data/mockData.dart';
import 'package:uitest/widgets/coverImage.dart';
import 'package:uitest/widgets/gradientAppBar.dart';
import 'package:uitest/widgets/inputTextField.dart';
import 'package:uitest/widgets/searchResults.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool loading = false;
  List<Course> searchResults = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: 'Search',
        showActions: searchResults.length > 0 ? 'filter' : '',
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
                        List<Course> res = await Future.delayed(
                            Duration(seconds: 5), () => courses);
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
