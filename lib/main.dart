import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/services/auth.dart';

import 'package:app/screens/splashscreen/splashScreen.dart';
import 'package:app/screens/onboarding/onboarding.dart';
import 'package:app/navigation/navigation.dart';
import 'package:app/screens/wrapper.dart';
import 'package:app/screens/home/home.dart';
import 'package:app/screens/settings/settings.dart';
import 'package:app/models/user.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Disables the debug ribbon
        home: SplashScreen(), // Shows splash screen as the first screen
        routes: <String, WidgetBuilder> {
          '/Intro_Slider': (BuildContext context) => new Boarding(),
          '/Navig': (BuildContext context) => new Navig(),
          '/Wrapper': (BuildContext context) => new Wrapper(),
          '/Home': (BuildContext context) => new Home(),
          '/Settings': (BuildContext context) => new Settings(),
        }
      ),
    );
  }
}