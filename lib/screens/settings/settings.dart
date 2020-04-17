import 'package:app/screens/authenticate/authenticate.dart';
import 'package:app/screens/authenticate/sign_in.dart';
import 'package:app/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:app/services/auth.dart';

import '../../config.dart';

class Settings extends StatelessWidget {

  // Makes it permanent for auth service
  final AuthService _auth = AuthService();
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<DocumentSnapshot>(
                future: Firestore.instance.collection('users').document(BusApp.sharedPreferences
                    .getString('users')).get(),
                builder: (_,snapshot){
              return snapshot.hasData?Column(
                children: <Widget>[

                  Text('First Name: ${snapshot.data.data['First Name']}'),
                  Text('Last Name: ${snapshot.data.data['Last Name']}'),
                  Text('Email: ${snapshot.data.data['Email']}'),
                ],
              ):Loading();
            }),
            RaisedButton(
              color: Colors.blue,
              child: Text('Sign Out'),
              onPressed: () async {
                // Makes user sign out
                print('d');
                await _auth.signOut(context);
//                .then((_){
//              Route newRoute = MaterialPageRoute(builder: (_)=>Authenticate());
//              Navigator.pushReplacement(context, newRoute);
//              print('hbhj');
//            }).catchError((e){
//              print(e.toString());
//            });
              },

            ),
          ],
        ),
      ),
    );
  }
}