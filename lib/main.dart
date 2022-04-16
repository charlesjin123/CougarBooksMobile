import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uitest/screens/splashScreen.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(DevicePreview(
    enabled: false,
    builder: (context) => MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  Color _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  Map<int, Color> goldMap = {
    50: Color.fromRGBO(197, 171, 53, .1),
    100: Color.fromRGBO(197, 171, 53, .2),
    200: Color.fromRGBO(197, 171, 53, .3),
    300: Color.fromRGBO(197, 171, 53, .4),
    400: Color.fromRGBO(197, 171, 53, .5),
    500: Color.fromRGBO(197, 171, 53, .6),
    600: Color.fromRGBO(197, 171, 53, .7),
    700: Color.fromRGBO(197, 171, 53, .8),
    800: Color.fromRGBO(197, 171, 53, .9),
    900: Color.fromRGBO(197, 171, 53, 1),
  };

  Map<int, Color> purpleMap = {
    50: Color.fromRGBO(34, 37, 89, .1),
    100: Color.fromRGBO(34, 37, 89, .2),
    200: Color.fromRGBO(34, 37, 89, .3),
    300: Color.fromRGBO(34, 37, 89, .4),
    400: Color.fromRGBO(34, 37, 89, .5),
    500: Color.fromRGBO(34, 37, 89, .6),
    600: Color.fromRGBO(34, 37, 89, .7),
    700: Color.fromRGBO(34, 37, 89, .8),
    800: Color.fromRGBO(34, 37, 89, .9),
    900: Color.fromRGBO(34, 37, 89, 1),
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cougar Books',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF222559, purpleMap), // purple 0xFF222559 gold 0xFFC5AB35
        primaryColor: _colorFromHex('#222559'), // gold #C5AB35 purple #222559
        accentColor: _colorFromHex('#C5AB35'),
        fontFamily: 'Ubuntu',
      ),
      home: SplashScreen(),
    );
  }
}
