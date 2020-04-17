import 'package:app/OrderDetails/particularBookingDetails.dart';
import 'package:app/models/orderDetails.dart';
import 'package:app/shared/loading.dart';
import 'package:app/triggers/calculateRent.dart';
import 'package:awesome_card/credit_card.dart';
import 'package:awesome_card/style/card_background.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'Widgets/wideButton.dart';
import 'addCard.dart';
import 'config.dart';
import 'models/creditCard.dart';
import 'triggers/cardChanger.dart';

class SelectCard extends StatefulWidget {
  final int totalAmount, adults, students, children;
  final String routeNumber;
  final bool isMain;

  const SelectCard(
      {Key key,
      this.totalAmount,
      this.adults,
      this.students,
      this.children,
      this.routeNumber,
      this.isMain = false})
      : super(key: key);

  @override
  _SelectCardState createState() => _SelectCardState();
}

int currentIndex = 0;

class _SelectCardState extends State<SelectCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Route route = MaterialPageRoute(builder: (_) => AddCard());
            Navigator.push(context, route);
          },
          label: Text('Add Card'),
          icon: Icon(Icons.add),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.isMain ? 'Your Cards' : 'Select Card',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
            Consumer<CardChanger>(builder: (context, address, _) {
              return Flexible(
                child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection('users')
                      .document(BusApp.sharedPreferences.getString('users'))
                      .collection('cards')
                      .snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? Center(child: Loading())
                        : snapshot.data.documents.length == 0
                            ? noCreditrCard()
                            : ListView.builder(
                                itemCount: snapshot.data.documents.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return CredditCardWidget(
                                    currentIndex: address.count,
                                    value: index,
                                    isMain: widget.isMain,
                                    routeNumber: widget.routeNumber,
                                    students: widget.students,
                                    adults: widget.adults,
                                    children: widget.children,
                                    creditCardID: snapshot
                                        .data.documents[index].documentID,
                                    totalAmount: widget.totalAmount,
                                    model: CreditCardModel.fromJson(
                                        snapshot.data.documents[index].data),
                                  );
                                });
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  noCreditrCard() {
    return Card(
      color: Colors.deepPurple.withOpacity(0.5),
      child: Container(
          height: 100,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.add_location, color: Colors.white),
              Text('You dont have any credit card with us'),
              Text('Add your card now !!'),
            ],
          )),
    );
  }
}

class CredditCardWidget extends StatefulWidget {
  final CreditCardModel model;
  final int currentIndex;
  final int value;
  final String creditCardID;
  final int totalAmount;
  final int adults, students, children;
  final String routeNumber;
  final bool isMain;

  const CredditCardWidget(
      {Key key,
      this.model,
      this.currentIndex,
      this.value,
      this.creditCardID,
      this.totalAmount,
      this.adults,
      this.students,
      this.children,
      this.routeNumber,
      this.isMain})
      : super(key: key);

  @override
  _CredditCardWidgetState createState() => _CredditCardWidgetState();
}

class _CredditCardWidgetState extends State<CredditCardWidget> {
  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Provider.of<CardChanger>(context, listen: false)
            .displayResult(widget.value);
      },
      child: Card(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                widget.isMain
                    ? Container()
                    : Radio(
                        groupValue: widget.currentIndex,
                        value: widget.value,
                        activeColor: Colors.deepPurple,
                        onChanged: (val) {
                          Provider.of<CardChanger>(context, listen: false)
                              .displayResult(val);
                          print(val);
                        },
                      ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    CreditCard(
                      width: widget.isMain ? 320 : 280,
                      height: 180,
                      cardNumber: widget.model.cardNumber,
                      cardExpiry: widget.model.expiryDate,
                      cardHolderName: widget.model.cardHolderName,
                      cvv: widget.model.cVV,
                      bankName: "Axis Bank",
                      frontBackground: CardBackgrounds.black,
                      backBackground: CardBackgrounds.white,
                      showShadow: true,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          Fluttertoast.showToast(msg: 'Please wait!!');
                          Firestore.instance
                            ..collection('users')
                                .document(
                                    BusApp.sharedPreferences.getString('users'))
                                .collection('cards')
                                .document(widget.creditCardID)
                                .delete()
                                .then((_) {
                              Fluttertoast.showToast(
                                  msg: 'Deleted Successfully');
                            }).catchError((_) {
                              Fluttertoast.showToast(msg: 'Error occured');
                            });
                        })
                  ],
                ),
              ],
            ),
            widget.value == Provider.of<CardChanger>(context).count
                ? widget.isMain
                    ? Container()
                    : WideButton(
                        message: 'Proceed',
                        onPressed: () {
                          String id =
                              DateTime.now().millisecondsSinceEpoch.toString();
                          var model = OrderDetailsModel(
                              amount: widget.totalAmount,
                              id: id,
                              creditCardId: widget.creditCardID,
                              nAdults: widget.adults,
                              nChildren: widget.children,
                              nStudents: widget.students,
                              routeNumberr: widget.routeNumber,
                              timestamp: id);
                          Fluttertoast.showToast(msg: "Please Wait");
                          Firestore.instance
                              .collection('users')
                              .document(
                                  BusApp.sharedPreferences.getString('users'))
                              .collection('bookings')
                              .document(id)
                              .setData(model.toJson())
                              .then((_) {
                            Route route = MaterialPageRoute(
                                builder: (c) => ParticularBookingDetails(
                                      model: model,
                                    ));
                            Navigator.push(context, route);
                          }).catchError((_) {
                            Fluttertoast.showToast(msg: "Some Error Occuured");
                          });
                          print(widget.model.toJson());
                        },
                      )
                : Container(),
          ],
        ),
      ),
    );
  }
}

class KeyText extends StatelessWidget {
  final String message;

  KeyText({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    );
  }
}
