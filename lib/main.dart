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

  Map<int, Color> color = {
    50: Color.fromRGBO(229, 45, 39, .1),
    100: Color.fromRGBO(229, 45, 39, .2),
    200: Color.fromRGBO(229, 45, 39, .3),
    300: Color.fromRGBO(229, 45, 399, .4),
    400: Color.fromRGBO(229, 45, 39, .5),
    500: Color.fromRGBO(229, 45, 39, .6),
    600: Color.fromRGBO(229, 45, 39, .7),
    700: Color.fromRGBO(229, 45, 39, .8),
    800: Color.fromRGBO(229, 45, 39, .9),
    900: Color.fromRGBO(229, 45, 39, 1),
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Charles Sales',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFFE52D27, color),
        primaryColor: _colorFromHex('#800080'),
        accentColor: _colorFromHex('#301934'),
        fontFamily: 'Ubuntu',
      ),
      home: SplashScreen(),
    );
  }
}
