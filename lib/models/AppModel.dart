import 'package:scoped_model/scoped_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'EditReceiptScreenModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'dart:io'; 
import 'CameraCaptureModel.dart';
enum Period { MONTHLY, WEEKLY, DAILY }

class AppModel extends Model {
  // User _user;
  Period _viewing_period = Period.DAILY;
  bool _alsoReceivePromosThruEmail;
  bool _receiveUniquePromos;
  bool _receiveOpenToAllPromos;
  List<String> _receipts_json_paths;
  FirebaseAuth mAuth;
  // String rootFilePath;
  EditReceiptScreenModel editReceiptScreenModel;
  CameraCaptureModel cameraCaptureModel;
  FirebaseUser user;
  Directory rootDir;
  List<String> dirList = ["/ReceiptsJson", "/ReceiptsImages", "/Settings"];
  // BuildContext context;

  // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  bool get alsoReceivePromosThruEmail => _alsoReceivePromosThruEmail;
  Period get viewing_period => _viewing_period;
  bool get receiveUniquePromos => _receiveUniquePromos;
  bool get receiveOpenToAllPromos => _receiveOpenToAllPromos;

  AppModel() {
    init();
  }

  void init() async {
    mAuth = FirebaseAuth.instance;
    user = await mAuth.currentUser(); 
    editReceiptScreenModel = EditReceiptScreenModel(this);
    cameraCaptureModel = CameraCaptureModel(this);
    rootDir = await getApplicationDocumentsDirectory(); 
    checkOrGenerateDirectories();
  }

  void checkOrGenerateDirectories() {
    for (int i = 0; i < dirList.length; i++) {
      if (FileSystemEntity.typeSync("${rootDir.path}/${dirList[i]}/") ==
          FileSystemEntityType.notFound) {
        print("${dirList[i]} not found so created folder");
        new Directory("${rootDir.path}/${dirList[i]}/").create(recursive: true);
      } else {
        print('exists');
      }
    }
  }

  Future<FirebaseUser> login(String email, String password) async {
    user = await mAuth.signInWithEmailAndPassword(
        email: email, password: password);
    print("The user is ${user.toString()}");
    init();
    return user;
  }

  logOut() {
    mAuth.signOut();
  }

  set receiveUniquePromos(bool value) {
    _receiveUniquePromos = value;
    notifyListeners();
  }

  set receiveOpenToAllPromos(bool value) {
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
}

class User {
  String username;
  String uid;
  FirebaseUser fbUser;
}
