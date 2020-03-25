
import 'package:flutter/foundation.dart';

class CardChanger extends ChangeNotifier{
  int index=0;
  int get count => index;

  displayResult(int newValue){
    index = newValue;
    notifyListeners();
  }

}