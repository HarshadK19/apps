import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:app/services/auth.dart';

class Settings extends StatelessWidget {

  // Makes it permanent for auth service
  final AuthService _auth = AuthService();
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          color: Colors.blue,
          child: Text('Sign Out'),
          onPressed: () async {
            // Makes user sign out
            await _auth.signOut();
          },
        ),
      ),
    );
  }
}