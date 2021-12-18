import 'package:flutter/material.dart';

import 'sign_in.dart';
import 'sign_up.dart';

class Authentication extends StatefulWidget {
  

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool isToggle = false;
  void toggleScreen() {
    setState(() {
      isToggle = !isToggle;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isToggle) {
      return SignUp(
        toggleScreen: toggleScreen,
      );
    } else {
      return SignIn(
        toggleScreen: toggleScreen,
      );
    }
  }
}
