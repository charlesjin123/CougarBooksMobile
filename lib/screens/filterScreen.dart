import 'package:flutter/material.dart';
import 'package:uitest/widgets/gradientAppBar.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  RangeValues _priceRange = RangeValues(500, 3000);
  List<String> _categories = [
    'Flutter',
    'Dart',
    'Angular',
    'Ionic',
  ];
  List<String> _selectedCategories = ['Dart'];
  List<int> _selectedRating = [5, 3, 2];
  List<int> _ratings = List.generate(5, (index) => index + 1);
  @override
  Widget build(BuildContext context) {
    var persistBottomButtons = <Widget>[
      Container(
        child: RaisedButton.icon(
          color: Theme.of(context).primaryColor,
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.save,
            color: Colors.white,
          ),
          label: Text('Apply',
              style: TextStyle(fontSize: 20, color: Colors.white)),
        ),
      )
    ];
    return Scaffold(
      appBar: GradientAppBar(
        title: 'Filter',
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.90,
          child: Column(
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  alignment: Alignment.centerLeft,
                  child: Row(children: <Widget>[
                    Text(
                      'Price',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '\$ ${_priceRange.start.round()}   -   \$ ${_priceRange.end.round()}',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 18,
                      ),
                    ),
                  ])),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20),
                child: RangeSlider(
                  divisions: 500,
                  min: 100,
                  max: 5000,
                  labels: RangeLabels('\$ ${_priceRange.start.round()}',
                      '\$ ${_priceRange.end.round()}'),
                  values: _priceRange,
                  activeColor: Theme.of(context).accentColor,
                  inactiveColor: Colors.grey[300],
                  onChanged: (RangeValues newValue) {
                    setState(() {
                      _priceRange = newValue;
                    });
                  },
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Category',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  )),
              SizedBox(height: 10),
              Wrap(
                children: _categories
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ActionChip(
                          label: Text(e),
                          onPressed: () {
                            setState(() {
                              _selectedCategories.contains(e)
                                  ? _selectedCategories.remove(e)
                                  : _selectedCategories.add(e);
                            });
                          },
                          labelStyle: TextStyle(
                              color: _selectedCategories.contains(e)
                                  ? Colors.white
                                  : Colors.black),
                          padding: EdgeInsets.all(8),
                          backgroundColor: _selectedCategories.contains(e)
                              ? Theme.of(context).accentColor
                              : Colors.grey[300],
                        ),
                      ),
                    )
                    .toList(),
              ),
              Container(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Rating',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  )),
              SizedBox(height: 10),
              ListView.builder(
                  shrinkWrap: true,
                  reverse: true,
                  padding: EdgeInsets.only(top: 1),
                  itemBuilder: (context, index) => ListTile(
                        dense: true,
                        title: Wrap(
                            children: List.generate(
                                _ratings[index],
                                (index) => Icon(
                                      Icons.star,
                                      color: Colors.yellow[800],
                                    ))),
                        leading: Checkbox(
                            value: _selectedRating.contains(_ratings[index]),
                            onChanged: (e) => {
                                  setState(() {
                                    e
                                        ? _selectedRating.add(_ratings[index])
                                        : _selectedRating
                                            .remove(_ratings[index]);
                                  })
                                }),
                      ),
                  itemCount: _ratings.length)
            ],
          ),
        ),
      ),
      persistentFooterButtons: persistBottomButtons,
    );
  }
}
