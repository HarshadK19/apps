import 'package:app/models/orderDetails.dart';
import 'package:app/screens/home/card.dart';
import 'package:app/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../config.dart';

class OrderCard extends StatelessWidget {
  final OrderDetailsModel model;

  const OrderCard({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          color: Colors.deepPurple,
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Bus Booked Successfully',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                width: 5,
              ),
              CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.grey,
                  child: Center(
                    child: Icon(
                      Icons.done,
                      color: Colors.white,
                      size: 14,
                    ),
                  )),
            ],
          ),
        ),
        Text("ID: ${model.id}"),
        Text('Total number of adults: ${model.nAdults}'),
        Text('Total number of children: ${model.nChildren}'),
        Text('Total number of students: ${model.nStudents}'),
        Text('Total Amount: ${model.amount.toString()}'),
        Text(
          DateFormat('dd MMM kk:mm').format(
              DateTime.fromMillisecondsSinceEpoch(int.parse(model.timestamp))),
          style: TextStyle(
              color: Colors.grey, fontSize: 12.0, fontStyle: FontStyle.italic),
        ),
        FutureBuilder<DocumentSnapshot>(
          future: Firestore.instance
              .collection('routes')
              .document(model.routeNumberr)
              .get(),
          builder: (_, document) {
            return document.hasData
                ? CustomCard(
                    //name: document['name'],
                    routenum: document.data['routenum'].toString(),
                    from: document.data['from'],
                    to: document.data['to'],
                    via: document.data['via'],
                    stop: document.data['stop'],
                    abv_to: document.data['abv_to'],
                    abv_from: document.data['abv_from'],
                    timeto: document.data['timeto'],
                    timefrom: document.data['timefrom'],
                  )
                : Loading();
          },
        ),
        IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              Fluttertoast.showToast(msg: 'Please wait!!');
              Firestore.instance
                ..collection('users')
                    .document(BusApp.sharedPreferences.getString('users'))
                    .collection('bookings')
                    .document(model.id)
                    .delete()
                    .then((_) {
                  Fluttertoast.showToast(msg: 'Deleted Successfully');
                }).catchError((_) {
                  Fluttertoast.showToast(msg: 'Error occured');
                });
            })
      ],
    ));
  }
}
