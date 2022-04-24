import 'package:flutter/material.dart';

class BottomTab {
  const BottomTab(this.title, this.icon, this.iconTitle);
  final String title;
  final IconData icon;
  final String iconTitle;
}

const List<BottomTab> allTabs = <BottomTab>[
  BottomTab('Buy', Icons.store, 'Buy'),
  BottomTab('Sell', Icons.attach_money, 'Sell'),
  BottomTab('Messages', Icons.chat, 'Messages'),
  BottomTab('Profile', Icons.person, 'Profile'),
];

// const List<String> categories = [
//   'English',
//   'History',
//   'Psychology',
//   'Economics',
//   'Computer Science',
//   'Physics',
//   'Biology',
//   'Chemistry',
//   'Math',
//   'Statistics',
//   'Geometry',
//   'Calculus',
//   'Linear Algebra',
// ];
const List<String> categories = [
  'AP',
  'IB'
  'History',
  'World History',
  'European History',
  'U.S. History',
  'Social Studies',
  'Economics',
  'Psychology',
  'English',
  'ESL',
  'Math',
  'Science',
  'Biology',
  'Chemistry',
  'Physics',
  'Engineering',
  'Design',
  'Computer Science',
  'World Language',
  'Chinese',
  'Spanish',
  'Arts',
  'Music',
];

class Course {
  final String title;
  final String image;
  final bool isFavourited;
  final List<String> categories;
  final String author;
  final bool isEnrolled;
  final double completedPercentage;
  Course({
    this.title,
    this.image,
    this.isFavourited = false,
    this.isEnrolled = false,
    this.categories,
    this.author,
    this.completedPercentage = 0,
  });
}

List<Course> courses = <Course>[
  Course(
      title: 'Advanced Flutter Development',
      author: 'John Rage',
      image: 'https://images.springer.com/sgw/books/medium/9781484249819.jpg',
      isFavourited: true,
      categories: ['Programming', 'Computer', 'Flutter']),
  Course(
      title: 'Fundamentals of Dart',
      author: 'Gary John',
      image:
          'https://images-na.ssl-images-amazon.com/images/I/51FcYLdeWzL._SX258_BO1,204,203,200_.jpg',
      isFavourited: true,
      isEnrolled: true,
      categories: ['Programming', 'Computer', 'Dart']),
  Course(
      title: 'Learn Flutter for Dummies',
      author: 'Sel Rob',
      image:
          'https://images-na.ssl-images-amazon.com/images/I/41i3DJwqWmL._SX328_BO1,204,203,200_.jpg',
      categories: ['Programming', 'Flutter'],
      isEnrolled: true,
      completedPercentage: 50),
  Course(
      title: 'Flutter Recipes for Ios & Android',
      author: 'Fu Ceng',
      image: 'https://images.springer.com/sgw/books/medium/9781484249819.jpg',
      categories: ['Programming', 'Flutter'],
      completedPercentage: 50),
  Course(
      title: 'React Native Cookbook',
      author: 'Dan Ward',
      image:
          'https://wish4book.com/uploads/posts/2019-03/1551977477_0063e674.jpg',
      categories: ['Programming', 'React'],
      isEnrolled: true,
      completedPercentage: 50),
  Course(
      title: 'React Js Blueprints',
      author: 'Siven A Rob',
      image:
          'https://images-na.ssl-images-amazon.com/images/I/51s0SFIFnEL._SX258_BO1,204,203,200_.jpg',
      categories: ['Programming', 'React']),
  Course(
      title: 'Learn Mobile App Development',
      author: 'Adam Dennis',
      image: 'https://images-na.ssl-images-amazon.com/images/I/61xHDotbooL.jpg',
      categories: ['Programming']),
  Course(
      title: 'Ionic 2',
      author: 'Sebastin Esch',
      image:
          'https://d2sofvawe08yqg.cloudfront.net/ionic2-book/hero2x?1549483078',
      categories: ['Programming', 'Ionic']),
];

final Map<String, dynamic> profile = {
  'userName': 'sannn',
  'firstName': 'Sudharsan',
  'lastName': 'San',
  'dob': '06-06-1988',
  'email': 'sanfoo@gmail.com',
  'phone': '+91-9876543210',
  'userImage':
      'https://img.favpng.com/17/24/10/computer-icons-user-profile-male-avatar-png-favpng-jhVtWQQbMdbcNCahLZztCF5wk.jpg',
};

final List<Map<String, dynamic>> curriculum = [
  {'title': 'Introduction', 'duration': '01:48 mins'},
  {'title': 'What is Flutter', 'duration': '05:54 mins'},
  {'title': 'Understanding Flutter Versions', 'duration': '02:49 mins'},
  {'title': 'Flutter Setup', 'duration': '19:35 mins'},
  {'title': 'Flutter & Material Design', 'duration': '01:15 mins'},
  {'title': 'Flutter Alternatives', 'duration': '06:06 mins'}
];
