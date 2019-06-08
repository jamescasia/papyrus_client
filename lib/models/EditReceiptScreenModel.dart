import 'package:scoped_model/scoped_model.dart';
import 'dart:core';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:papyrus_client/data_models/Receipt.dart';
import 'dart:convert';
import 'AppModel.dart';
import 'dart:io';

class EditReceiptScreenModel extends Model {
  TextEditingController _controller = TextEditingController();
  TextEditingController get controller => _controller;
  Receipt _receipt;
  bool _changed;
  AppModel appModel;
  String currentImagePath;
  // ReceiptItem _currentReceiptItem = ReceiptItem("", 0, 0);
  // set currentReceiptItem(ReceiptItem item ) => _currentReceiptItem = item;

  EditReceiptScreenModel(this.appModel) {
    // appModel = appModel;
    _changed = false;
    _receipt = Receipt()
      ..dateTime = DateTime.now().toIso8601String()
      ..time_stamp = DateTime.now().millisecondsSinceEpoch.toString();
  }

  createReceipt(){

    
  }


  setCurrentImagePath(String path){
    currentImagePath = path;
    _receipt.imagePath = currentImagePath;
    notifyListeners();
  }
   

  void saveReceiptToJsonAndToFile() {
    print("locals" + appModel.rootDir.path);
    print("saving");

    File file = new File(
        '${appModel.rootDir.path}/ReceiptsJson/${_receipt.time_stamp}.json');
    file.writeAsString(jsonEncode(_receipt.toJson()));

    readReceiptFromJsonFile(file.path);


  }

  Future<String> readReceiptFromJsonFile(String path) async {
    String content = await File(path).readAsString();

    print("content of receipt" + content);
    return content;
  }

  void newReceiptFromOCR() {}

  set changed(bool c) => _changed = c;
  bool get changed => _changed;

  Receipt get receipt => _receipt;

  set controller(TextEditingController controller) {
    _controller = controller;
    notifyListeners();
  }

  void addItemToReceipt(ReceiptItem item) {
    _receipt.addReceiptItem(item);
    notifyListeners();
  }

  void removeItemFromReceipt(ReceiptItem item) {
    _receipt.removeReceiptItem(item);

    notifyListeners();
  }

  void update() {
    _receipt.displayItems();

    notifyListeners();
  }
}
