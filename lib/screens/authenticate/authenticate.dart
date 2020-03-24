import 'package:flutter/material.dart';

import 'package:app/screens/authenticate/sign_in.dart';
import 'package:app/screens/authenticate/register.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  // function for toggle
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) { // function to toggle between sign in and sign up
      return SignIn(
        toggleView: toggleView
      );
    }
    else {
      return Register(
        toggleView: toggleView
      );
    }
  }
}