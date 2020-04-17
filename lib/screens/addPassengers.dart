import 'package:app/triggers/calculateRent.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../makePayment.dart';

class AddPassengers extends StatefulWidget {
  final String routeNumber;

  const AddPassengers({Key key, this.routeNumber}) : super(key: key);

  @override
  _AddPassengersState createState() => _AddPassengersState();
}

class _AddPassengersState extends State<AddPassengers> {
  final adults = TextEditingController(text: 0.toString());
  final students = TextEditingController(text: 0.toString());
  final children = TextEditingController(text: 0.toString());

  @override
  Widget build(BuildContext context) {
    print('passengers');
    print(Provider.of<CalculateRent>(context, listen: false).count);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              print('Value = $value');
              if (value.isEmpty) {
                print('Empty');
                value = 0.toString();
              }
              Provider.of<CalculateRent>(context, listen: false).displayResult(
                  int.parse(value),
                  int.parse(students.text),
                  int.parse(children.text));
            },
            decoration: InputDecoration(labelText: 'Enter number of Adults'),
            controller: adults,
          ),
          TextField(
            controller: students,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              if (value.isEmpty) {
                print('Empty');
                value = 0.toString();
              }
              Provider.of<CalculateRent>(context, listen: false).displayResult(
                  int.parse(adults.text),
                  int.parse(value),
                  int.parse(children.text));
            },
            decoration: InputDecoration(labelText: 'Enter number of Students'),
          ),
          TextField(
            keyboardType: TextInputType.number,
            controller: children,
            onChanged: (value) {
              if (value.isEmpty) {
                print('Empty');
                value = 0.toString();
              }
              Provider.of<CalculateRent>(context, listen: false).displayResult(
                int.parse(adults.text),
                int.parse(students.text),
                int.parse(value),
              );
            },
            decoration: InputDecoration(labelText: 'Enter number of children'),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Total Cost: '),
              Consumer<CalculateRent>(
                builder: (_, model, __) {
                  return Text(model.count.toString());
                },
              ),
            ],
          ),
          Consumer<CalculateRent>(
            builder: (_, model, __) {
              return model.totalPassengers > 64
                  ? Text("Number of passengers should not exceed 64")
                  : Container();
            },
          ),
          RaisedButton(
            onPressed: () {

              if (Provider.of<CalculateRent>(context, listen: false).count ==
                  0) {
                Fluttertoast.showToast(
                    msg: 'Please select atleast 1 passenger');
              }
              else if(Provider.of<CalculateRent>(context, listen: false).totalPassengers > 64){
                Fluttertoast.showToast(
                    msg: "Number of passengers should not exceed 64");
              }
              else {
                print(children.text);
                Route route = MaterialPageRoute(
                    builder: (_) => SelectCard(
                          routeNumber: widget.routeNumber,
                          totalAmount:
                              Provider.of<CalculateRent>(context, listen: false)
                                  .count,
                          children: children.text.isEmpty
                              ? 0
                              : int.parse(children.text),
                          adults:
                              adults.text.isEmpty ? 0 : int.parse(adults.text),
                          students: students.text.isEmpty
                              ? 0
                              : int.parse(students.text),
                        ));
                Provider.of<CalculateRent>(context, listen: false).displayResult(0, 0, 0);
                Navigator.push(context, route);
              }
            },
            child: Text('Make Payment'),
          )
        ],
      ),
    );
  }
}
