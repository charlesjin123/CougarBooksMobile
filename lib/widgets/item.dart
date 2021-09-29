class Item {
  String name;
  double price;
  String imageUrl;
  String id;
  String details;
  String uid;
  int timestamp;
  List<dynamic> category;
  var longitude;
  var latitude;

  Item(this.id, this.name, this.price, this.details, this.imageUrl, this.uid, this.timestamp, this.category, this.longitude, this.latitude);
}
