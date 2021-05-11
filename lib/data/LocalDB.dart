import 'package:uitest/widgets/item.dart';

class LocalDB {
  static String uid;
  static Map<String, dynamic> profile;
  static double longitude;
  static double latitude;

  static double min = 0;
  static double max = 5000;
  static double minDist = 0;
  static double maxDist = 5000;
  static double minPostDist = 0;
  static double maxPostDist = 5000;
  static List<String> selectedCategories = [];

  static List<Item> items;
}