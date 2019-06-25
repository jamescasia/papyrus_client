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
import 'package:mlkit/mlkit.dart';
import 'package:http/http.dart' as http;

class EditReceiptScreenModel extends Model {
  TextEditingController _controller = TextEditingController();
  TextEditingController get controller => _controller;
  Receipt _receipt;
  bool _changed;
  AppModel appModel;
  bool formIsValid = false;
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

  launch() {
    scanText(_receipt.imagePath);
  }

  createReceipt() {
    String time = DateTime.now().toLocal().millisecondsSinceEpoch.toString();
    _receipt = Receipt()
      ..dateTime = DateTime.now().toLocal().toIso8601String()
      ..time_stamp = time
      ..imagePath = "${appModel.dirMap['ReceiptsImages']}/${time}.png";
  }

  // setCurrentImagePath(String path){
  //   _receipt.imagePath = path;
  //   notifyListeners();
  // }
  void saveReceipt() {
    appModel.addReceiptandSaveToStorage(_receipt);
  }

  void saveReceiptToJsonAndToFile() {
    print("locals" + appModel.rootDir.path);
    print("saving");

    File file =
        new File('${appModel.dirMap['Receipts']}/${_receipt.time_stamp}.json');
    file.writeAsString(jsonEncode(_receipt.toJson()));

    readReceiptFromJsonFile(file.path);
  }

  Future<String> readReceiptFromJsonFile(String path) async {
    String content = await File(path).readAsString();

    print("content of receipt" + content);
    return content;
  }
//  Future<List<News>> fetchNews(id) async {
//     newsLoaded = false;
//     notifyListeners();
//     String url;
//     if (id == 1) {
//       url = Constant.base_url +
//           "top-headlines?country=in&category=business&apiKey=" +
//           Constant.key;
//     } else if (id == 2) {
//       url = Constant.base_url +
//           "everything?q=business&sources?language=en&sortBy=publishedAt&apiKey=" +
//           Constant.key;
//     } else if (id == 3) {
//       url = Constant.base_url +
//           "top-headlines?sources=techcrunch&apiKey=" +
//           Constant.key;
//     } else if (id == 4) {
//       url = Constant.base_url +
//           "everything?q=apple&from=2018-07-14&to=2018-07-14&sortBy=popularity&apiKey=" +
//           Constant.key;
//     } else if (id == 5) {
//       url = Constant.base_url +
//           "everything?domains=wsj.com&apiKey=" +
//           Constant.key;
//     }
//     final response = await http.get(url);

//     var res = await compute(parsenews, response.body);
//     newsLoaded = true;
//     notifyListeners();
//     return res;
//   }
  void scanText(String filePath) async {
    List<int> imageBytes = await File(filePath).readAsBytes();
    // print(imageBytes);
    String base64Image = base64Encode(imageBytes);
   var res =  await http.post("https://api.taggun.io/api/receipt/v1/verbose/encoded",headers: {'apikey': '7c1afc00932f11e98bfadfb7eb1aa8b5'},body: 
    
    jsonEncode({
  "image": base64Image,
  "filename": "example.jpg",
  "contentType": "image/jpeg",
  "refresh": false,
  "incognito": true, 
  "ignoreMerchantName": "string",
  "language": "en"
})
    
    );

    print("The boooody isssssss"+res.body);



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
    print('dfafad');

    // notifyListeners();
  }
}
