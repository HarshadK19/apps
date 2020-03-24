
import 'package:app/screens/pay/interface.dart';
import 'package:flutter/material.dart';

class Pay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Pay')
        ),
        automaticallyImplyLeading: false,
      ),
     body: 
         Interface(),
    );
  }
}