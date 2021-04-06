import 'package:flutter/material.dart';
import 'package:uitest/data/mockData.dart';
import 'package:uitest/screens/ItemDetailScreen.dart';
import 'package:uitest/widgets/item.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({
    Key key,
    @required this.searchResults,
  }) : super(key: key);

  final List<Item> searchResults;

  @override
  Widget build(BuildContext context) {
    return searchResults.length > 0
        ? ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var tmpItem = searchResults[index];
              return ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ItemDetailScreen(tmpItem)));
                  },
                  contentPadding: EdgeInsets.all(2),
                  title: Text(tmpItem.name),
                  subtitle: Text("\$" + tmpItem.price.toString()),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(tmpItem.imageUrl),
                    backgroundColor: Colors.black,
                    radius: 25,
                  ));
            },
            itemCount: searchResults.length,
            scrollDirection: Axis.vertical,
          )
        : Center(
            child: Text('No Products',
                style: TextStyle(fontSize: 20, color: Colors.grey[500])));
  }
}
