import 'package:scoped_model/scoped_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:papyrus_client/data_models/Receipt.dart';


class EditReceiptScreenModel extends Model {
  
  TextEditingController _controller = TextEditingController();
  TextEditingController get controller => _controller;

  Receipt receipt = new Receipt() ;
 

  set controller(TextEditingController controller){ 
    _controller = controller;
    notifyListeners();

  }

  void addItemToReceipt(ReceiptItem item){
    receipt.addReceiptItem(item);
    notifyListeners();
  }

  void removeItemFromReceipt(ReceiptItem item){
    receipt.removeReceiptItem(item);
    
    notifyListeners();
  }

  void update(){
    receipt.displayItems();

    notifyListeners();
  }

 


}