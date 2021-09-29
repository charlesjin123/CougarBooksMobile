import 'package:flutter/material.dart';
import 'package:uitest/screens/forgotPasswordScreen.dart';
import 'package:uitest/screens/signupScreen.dart';
import 'package:uitest/widgets/gradientAppBar.dart';
import 'package:uitest/widgets/loginForm.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GradientAppBar(title: 'Login'),
        body: Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/open-book.png'),
                            fit: BoxFit.contain,
                            alignment: Alignment.center)),
                  ),
                  SizedBox(height: 15),
                  Text("Welcome to Cougar Books!"),
                  SizedBox(height: 10),
                  LoginForm(),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 2.0, bottom: 15.0),
                  //   child: GestureDetector(
                  //     onTap: () => Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => ForgotPasswordScreen())),
                  //     child: Text('Forgot Password?',
                  //         style: TextStyle(
                  //             fontSize: 15,
                  //             fontWeight: FontWeight.w600,
                  //             color: Theme.of(context).primaryColor)),
                  //   ),
                  // ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Don\'t have an account?',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen())),
                          child: Text('Sign Up',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).primaryColor)),
                        ),
                      ]),
                ],
              ),
            )));
  }
}
