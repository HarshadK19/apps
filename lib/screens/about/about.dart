import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Container(
        color: Colors.blueGrey[50],
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.fromLTRB(2, 80, 2, 10),
        child: new Column(children: <Widget>[
          new Material(
            //elevation: 5.0,
            borderRadius: BorderRadius.circular(40.0),
            child: Image.asset(
              'images/about.gif',
              width: 320,
              height: 290,
            ),
            color: Colors.white,
          ),
          new Container(
            padding: EdgeInsets.symmetric(
              vertical: 30.0,
              horizontal: 20.0,
            ),
            //color: Colors.grey,
            child: new Text(
              'About Bo Bis',
              textAlign: TextAlign.center,
              style: new TextStyle(
                letterSpacing: 3.0,
                wordSpacing: 5.0,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[600],
              ),
            ),
          ),
          new Container(
            padding: EdgeInsets.symmetric(
              vertical: 6.0,
              horizontal: 5.0,
            ),
            child: new Text(
              'Developped by KISSOON HARSHAD \n'
              'Based on Rose Hill Transport Ltd \n'
              'For enquiries email on hdkissoon"student.udm.ac.mu\n',
              textAlign: TextAlign.center,
              style: new TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[400],
              ),
            ),
          ),
          new Container(
            padding: EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 5.0,
            ),
            child: new Text(
              '©Copyright 2019-2020 \n',
              textAlign: TextAlign.center,
              style: new TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey[500],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
