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
import 'package:shared_preferences/shared_preferences.dart';

import 'config.dart';
import 'screens/addPassengers.dart';
import 'triggers/calculateRent.dart';
import 'triggers/cardChanger.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  BusApp.sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    print(BusApp.sharedPreferences
        .getString('users'));

    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CalculateRent()),
          ChangeNotifierProvider(create: (_) => CardChanger()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false, // Disables the debug ribbon
            home:
            //AddPassengers(),
            SplashScreen(), // Shows splash screen as the first screen
            routes: <String, WidgetBuilder>{
              '/Intro_Slider': (BuildContext context) => new Boarding(),
              '/Navig': (BuildContext context) => new Navig(),
              '/Wrapper': (BuildContext context) => new Wrapper(),
              '/Home': (BuildContext context) => new Home(),
              '/Settings': (BuildContext context) => new Settings(),
            }),
      ),
    );
  }
}
