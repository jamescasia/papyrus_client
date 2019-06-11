import 'package:scoped_model/scoped_model.dart';
import 'AppModel.dart';
import 'dart:async';
import 'dart:io';
import 'package:papyrus_client/data_models/Receipt.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class ReceiptsScreenModel extends Model {
  AppModel appModel; 
  bool fetched;

  ReceiptsScreenModel(this.appModel) {}

  launch() {
    // fetchReceiptHeaders();
  }

  // Future<bool> fetchReceiptHeaders() async {
  //   for (String rp in receipts) {
  //     File rJSON = File(rp);
  //     Map map = jsonDecode(await rJSON.readAsString());
  //     Receipt receipt = new Receipt.fromJson(map);
  //     var rh = new ReceiptHeader(receipt.dateTime, receipt.merchant,
  //         receipt.total, receipt.items[0].name, null);

  //     receiptHeaders.add(rh);
  //   }

  //   return true;
  // }

  
}

