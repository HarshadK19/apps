import 'package:app/OrderDetails/orderCard.dart';
import 'package:app/models/orderDetails.dart';
import 'package:app/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../config.dart';

class MyBookings extends StatefulWidget {
  @override
  _MyBookingsState createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            centerTitle: true,
            title: Text("My Bookings"),
            backgroundColor: Colors.blueGrey,
          ),
          body: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('users')
                  .document(BusApp.sharedPreferences.getString('users'))
                  .collection('bookings').orderBy('timestamp',descending: true)
                  .snapshots(),
              builder: (_, snapshot) {
                return snapshot.hasData
                    ? ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (_, index) {
                          return OrderCard(
                            model: OrderDetailsModel.fromJson(
                                snapshot.data.documents[index].data),
                          );
                        })
                    : Center(child: Loading());
              })),
    );
  }
}
