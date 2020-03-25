
import 'package:app/OrderDetails/orderCard.dart';
import 'package:app/models/orderDetails.dart';
import 'package:app/navigation/navigation.dart';
import 'package:app/screens/home/home.dart';
import 'package:flutter/material.dart';


class ParticularBookingDetails extends StatelessWidget {
  final OrderDetailsModel model;

  const ParticularBookingDetails({Key key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: (){
          Route newRoute = MaterialPageRoute(builder: (_)=>Navig(title: '',));
          Navigator.pushAndRemoveUntil(context, newRoute,(Route<dynamic> route) => false);
          return ;
        },
        child: Center(
              child : OrderCard(model: model,),
          ),
        ),
    );
  }
}
