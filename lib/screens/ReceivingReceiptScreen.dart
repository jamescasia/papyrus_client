import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReceiveReceiptScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: CircularProgressIndicator(),
      ),
      
    );
  }
}