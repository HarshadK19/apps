import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:app/screens/home/card.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // appBar: new AppBar(
      //   title: new Text('Home',),
      // ),
      body: Center(
        child: Container(
          color: Colors.red[400],
          padding: const EdgeInsets.all(20.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('routes').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return new CircularProgressIndicator();
                default:
                  return new ListView(
                    children: snapshot.data.documents.map((DocumentSnapshot document) {
                      return new CustomCard(
                        //name: document['name'],
                        routenum: document['routenum'].toString(),
                        from: document['from'],
                        to: document['to'],
                        via: document['via'],
                        stop: document['stop'],
                        abv_to: document['abv_to'],
                        abv_from: document['abv_from'],
                        timeto: document['timeto'],
                        timefrom: document['timefrom'],
                      );
                    }).toList(),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}