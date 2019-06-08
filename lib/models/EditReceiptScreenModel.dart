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
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class EditReceiptScreenModel extends Model {
  TextEditingController _controller = TextEditingController();
  TextEditingController get controller => _controller;
  Receipt _receipt;
  bool _changed;
  AppModel appModel;
  // ReceiptItem _currentReceiptItem = ReceiptItem("", 0, 0);
  // set currentReceiptItem(ReceiptItem item ) => _currentReceiptItem = item;

  EditReceiptScreenModel(this.appModel) {
    // appModel = appModel;
    _changed = false;
  }

  deleteReceiptImage() {
    try {
      File(_receipt.imagePath).delete();
      print("succeeded");
    } catch (a) {
      print("deleted");
    }
  }

  launch(){

    scanText(_receipt.imagePath);




  }




  createReceipt() {
    String time = DateTime.now().millisecondsSinceEpoch.toString();
    _receipt = Receipt()
      ..dateTime = DateTime.now().toIso8601String()
      ..time_stamp = time
      ..imagePath = "${appModel.rootDir.path}/ReceiptsImages/${time}.png";
  }

  // setCurrentImagePath(String path){
  //   _receipt.imagePath = path;
  //   notifyListeners();
  // }

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

    void scanText(String filePath) async {
      print("scanning images");
    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFilePath(filePath);
    final TextRecognizer textRecognizer =
        FirebaseVision.instance.textRecognizer();
    final VisionText visionText =
        await textRecognizer.processImage(visionImage);
    String text = visionText.text;
    for (TextBlock block in visionText.blocks) {
      // final Rect boundingBox = block.boundingBox;
      // final List<Offset> cornerPoints = block.cornerPoints;
      final String text = block.text;
      // final List<RecognizedLanguage> languages = block.recognizedLanguages;

      for (TextLine line in block.lines) {
        // Same getters as TextBlock
        for (TextElement element in line.elements) {
          print(element.text.toString());
          // Same getters as TextBlock
        }
      }
    } 

    _receipt.merchant = "Jollibee";
    _receipt.total = 123;
    // 
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
