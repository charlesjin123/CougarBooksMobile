import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uitest/screens/loginScreen.dart';

import 'homeScreenNotLoggedIn.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToApp();
  }

  navigateToApp() async {
    await FirebaseAuth.instance.signOut();
    var _duration = Duration(seconds: 2);
    return Timer(
        _duration,
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(

              builder: (BuildContext context) => HomeScreenNotLoggedIn())));

        // builder: (BuildContext context) => LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: Stack(children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/NewCougarBooksLogoTransparent.png'),
                      fit: BoxFit.contain,
                      alignment: Alignment.center)),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Text('Cougar Books',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColor,
                      letterSpacing: 3,
                      wordSpacing: 3,
                    ))),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
        ),
      ]),
    ));
  }
}
