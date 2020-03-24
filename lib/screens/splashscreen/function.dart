import 'package:flutter/material.dart';

import 'dart:async';
import 'package:google_fonts/google_fonts.dart';

import './splashScreen.dart';

class SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/Intro_Slider');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: new Image.asset('assets/images/splashscreen/bus.gif'),
              ),
            ),
            Align(
                alignment: FractionalOffset.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.all(45.0),
                  child: Text(
                    "MoBis",
                    style: GoogleFonts.fredokaOne(
                      fontSize: 20,
                    ),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
