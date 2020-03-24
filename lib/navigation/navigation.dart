import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

import 'package:app/screens/home/home.dart';
import 'package:app/screens/settings/settings.dart';
import 'package:app/screens/pay/pay.dart';
import 'package:app/screens/about/about.dart';

class Navig extends StatefulWidget {
  Navig({Key key, this.title}) : super(key: key);

  final String title;

  @override
  NavigState createState() => NavigState();
}

class NavigState extends State<Navig> {
  int currentIndex = 0;
  final _pageOptions =[
    Home(),
    Pay(),
    About(),
    //Messages(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: _pageOptions[currentIndex],

      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Colors.lightBlueAccent,
        selectedIndex: currentIndex,
        showElevation: true,
        itemCornerRadius: 8,
        curve: Curves.easeInBack,
        onItemSelected: (index) => setState(() {
          currentIndex = index;
        }),
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text('Home'),
            activeColor: Colors.white,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.card_membership),
            title: Text('Pay'),
            activeColor: Colors.purpleAccent,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.info),
            title: Text(
              'About',
            ),
            activeColor: Colors.pink,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
            activeColor: Colors.blue,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}