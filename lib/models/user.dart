import 'package:firebase_auth/firebase_auth.dart';

class User {
  final currentuser = FirebaseUser;
  final String uid;
  User({this.uid});
}