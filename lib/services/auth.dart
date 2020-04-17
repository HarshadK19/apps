import 'package:app/navigation/navigation.dart';
import 'package:app/screens/authenticate/authenticate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:app/models/user.dart';

import '../config.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Map user Data
  Map<String, dynamic> userData = Map();

  // Current User
  FirebaseUser currentuser;

  // create user object based on Firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // Auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // sign in annonymously
  Future signInAnonymous() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }
    catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password,BuildContext context) async {
    try { //Requesting to firebase
    // ceate user
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password).catchError((e){

      });
      FirebaseUser user = result.user;
      currentuser = user;
      await BusApp.sharedPreferences
          .setString('users', currentuser.uid);
      // if successfull return this
      return _userFromFirebaseUser(user);
    }
    catch(e) {
      print(e.toString());
      throw('Error');
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password, Map<String, dynamic> userdata) async {
    try { //Requesting to firebase
    // create user
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      currentuser = user;
      _savedatauser(userdata,currentuser);
      // if successfull return this
      return _userFromFirebaseUser(user); 
    }
    catch(e) {
      print(e.toString());
      return null;
    }
  }

  // Sava data from user
  Future _savedatauser(Map<String, dynamic> userdata, FirebaseUser currentuser) async {
    await Firestore.instance.collection('users').document(currentuser.uid).setData(userdata);
    await BusApp.sharedPreferences
        .setString('users', currentuser.uid);
  }


  // Sign In with Google
  Future<FirebaseUser> googlelogin() async {
    try {
      final result = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await result.authentication;
      if(result.id != User().uid)
      {
        final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken, 
          accessToken: googleAuth.accessToken
        );
        final AuthResult authResult = await _auth.signInWithCredential(credential);
        assert(authResult.user.email != null);
        assert(authResult.user.displayName != null);
        assert(authResult.user.photoUrl != null);
        currentuser = authResult.user;
        await BusApp.sharedPreferences
            .setString('users', currentuser.uid);
        return currentuser;
      }
    }
    catch(e)
    {
      print(e);
    }
  }

  // sign out
  Future signOut(BuildContext context) async {
    try {
      currentuser = null;
      return await _auth.signOut().then((_){
        print('singinii out');
                      Route newRoute = MaterialPageRoute(builder: (_)=>Authenticate());
              Navigator.pushReplacement(context, newRoute);

      });
    }
    catch(e) {
      print(e.toString());
      return null;
    }
  }
}