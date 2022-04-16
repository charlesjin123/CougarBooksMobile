import 'package:flutter/material.dart';

import 'package:uitest/data/mockData.dart';
import 'package:uitest/screens/CourseDetailScreen.dart';
import 'package:uitest/screens/ItemDetailScreen.dart';
import 'package:uitest/widgets/item.dart';

class ProductBanner extends StatelessWidget {
  final Item item;
  const ProductBanner({
    Key key,
    this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ItemDetailScreen(item)));
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            border: Border.all(color: Color(int.parse('FF222559', radix: 16)), width: 4,),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.88,
              height: MediaQuery.of(context).size.height * 0.3,
              margin: EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  //color: Theme.of(context).primaryColor,
                  image: DecorationImage(
                      image: NetworkImage(item.imageUrl == null ? "https://complianz.io/wp-content/uploads/2019/03/placeholder-300x202.jpg" : item.imageUrl),
                      fit: BoxFit.cover)),
            ),
            SizedBox(height: 2),
            Container(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  //"\$" + item.price.toString() + " - " + (item.name.length > 30 ? item.name.substring(0, 30)+"..." : item.name),
                  "\$" + item.price.toString() + " - " + item.name,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
    // return Container(
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: <Widget>[
    //       GestureDetector(
    //         onTap: () {
    //           Navigator.of(context).push(MaterialPageRoute(
    //               builder: (context) => ItemDetailScreen(item)));
    //         },
    //         child: Container(
    //           width: MediaQuery.of(context).size.width * 0.9,
    //           height: MediaQuery.of(context).size.height * 0.3,
    //           decoration: BoxDecoration(
    //               shape: BoxShape.rectangle,
    //               borderRadius: BorderRadius.all(Radius.circular(10)),
    //               //color: Theme.of(context).primaryColor,
    //               image: DecorationImage(
    //                   image: NetworkImage(item.imageUrl == null ? "https://complianz.io/wp-content/uploads/2019/03/placeholder-300x202.jpg" : item.imageUrl),
    //                   fit: BoxFit.cover)),
    //         ),
    //       ),
    //       SizedBox(height: 2),
    //       Container(
    //         child: Padding(
    //           padding: EdgeInsets.all(10),
    //           child: Text(
    //             //"\$" + item.price.toString() + " - " + (item.name.length > 30 ? item.name.substring(0, 30)+"..." : item.name),
    //             "\$" + item.price.toString() + " - " + item.name,
    //             style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );
    // horizontal:
    // return Container(
    //   width: 150,
    //   height: 140,
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: <Widget>[
    //       GestureDetector(
    //         onTap: () {
    //           Navigator.of(context).push(MaterialPageRoute(
    //               builder: (context) => ItemDetailScreen(item)));
    //         },
    //         child: Container(
    //           width: 150,
    //           height: 100,
    //           decoration: BoxDecoration(
    //               shape: BoxShape.rectangle,
    //               borderRadius: BorderRadius.all(Radius.circular(10)),
    //               //color: Theme.of(context).primaryColor,
    //               image: DecorationImage(
    //                   image: NetworkImage(item.imageUrl == null ? "https://complianz.io/wp-content/uploads/2019/03/placeholder-300x202.jpg" : item.imageUrl),
    //                   fit: BoxFit.cover)),
    //         ),
    //       ),
    //       SizedBox(height: 2),
    //       Container(
    //         child: Padding(
    //           padding: const EdgeInsets.all(1.0),
    //           child: Text(
    //             "\$" + item.price.toString() + "  " + (item.name.length > 25 ? item.name.substring(0, 25)+"..." : item.name),
    //             style: TextStyle(fontWeight: FontWeight.w400),
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}
