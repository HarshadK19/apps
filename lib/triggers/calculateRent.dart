import 'package:flutter/foundation.dart';


class CalculateRent extends ChangeNotifier{
  int totalAmount=0;
  int totalPassengers=0;
  int get count => totalAmount;
  int get passengers => totalPassengers;

  Future<void> displayResult(int numberOfAdults,int students,int children) async {
    //_counter++;
    totalAmount= numberOfAdults*30 + students*17+ children*12;
    totalPassengers = numberOfAdults+students+children;
      notifyListeners();
  }

}