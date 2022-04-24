import 'package:flutter/material.dart';
import 'package:uitest/widgets/item.dart';

class ItemHighlights extends StatelessWidget {
  Item item;

  ItemHighlights(this.item);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        width: MediaQuery.of(context).size.width * .9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Product Info',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  )),
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(Icons.label),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
              title: Text(item.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  )),
              dense: true,
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(Icons.attach_money),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
              title: Text("\$" + item.price.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  )),
              dense: true,
            ),
          ],
        ),
      ),
    );
  }
}
