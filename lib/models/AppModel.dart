import 'package:scoped_model/scoped_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'EditReceiptScreenModel.dart';


enum Period { MONTHLY, WEEKLY, DAILY } 

class AppModel extends Model {

 
  User _user;
  Period _viewing_period = Period.DAILY;
  bool _alsoReceivePromosThruEmail;
  bool _receiveUniquePromos;
  bool _receiveOpenToAllPromos;
  List<String> _receipts_json_paths;

  User get user => _user; 
  bool get alsoReceivePromosThruEmail => _alsoReceivePromosThruEmail; 
  Period get viewing_period => _viewing_period;
  bool get receiveUniquePromos => _receiveUniquePromos;
  bool get receiveOpenToAllPromos => _receiveOpenToAllPromos;


  
  String directoryPath;
  EditReceiptScreenModel editReceiptScreenModel = EditReceiptScreenModel(); 
  // ChartScreenModel chartScreenModel;
  


  AppModel(){
    init(); 
  }

  set user(User user) {
    _user = user;
    notifyListeners();
  }

  set receiveUniquePromos(bool value){ 
    _receiveUniquePromos = value;
    notifyListeners();
  }

  set receiveOpenToAllPromos(bool value){
    _receiveOpenToAllPromos = value;
    notifyListeners();
  }

  set alsoReceivePromosThruEmail(bool value) {
    _alsoReceivePromosThruEmail = value;
    notifyListeners();
  }

  set viewing_period(Period period) {
    _viewing_period = period; 
    notifyListeners();
  }

  

  void init() async {
    
    print("The local path is !! : "+_localPath.toString());

    // directoryPath =  



  }

  Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}






}

class User {
  String username;
  String uid;
}

 