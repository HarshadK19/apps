import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:app/navigation/navigation.dart';
import 'package:app/models/user.dart';
import 'package:app/screens/authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    
    //return either Home or Authenticate widget
    if (user == null) {
      return Authenticate(); // gives back authentication screen
    }
    else
    {
      return Navig(); // goes on naviagtion tab first screen
    }
  }
}