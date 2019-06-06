import 'package:scoped_model/scoped_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:papyrus_client/data_models/Receipt.dart';


class EditReceiptScreenModel extends Model {
  
  TextEditingController _controller = TextEditingController();
  TextEditingController get controller => _controller;
  // ReceiptItem _currentReceiptItem = ReceiptItem("", 0, 0);
  // set currentReceiptItem(ReceiptItem item ) => _currentReceiptItem = item;

  bool _changed = false;
  Receipt _receipt = Receipt() ;

  set changed(bool c) => _changed = c;
  bool get changed => _changed;

  
  Receipt get receipt => _receipt;
 

  set controller(TextEditingController controller){ 
    _controller = controller;
    notifyListeners();

  }

  void addItemToReceipt(ReceiptItem item){
    _receipt.addReceiptItem(item);
    notifyListeners();
    
  }

  void removeItemFromReceipt(ReceiptItem item){
    _receipt.removeReceiptItem(item);
    
    notifyListeners();
  }

  void update(){
    _receipt.displayItems();

    notifyListeners();
  }



 


} 