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

enum Period { MONTHLY, WEEKLY, DAILY }

class AppModel extends Model {
  // User _user;
  Period _viewing_period = Period.DAILY;
  bool _alsoReceivePromosThruEmail;
  bool _receiveUniquePromos;
  bool _receiveOpenToAllPromos;
  List<String> _receipts_json_paths;
  FirebaseAuth mAuth;
  String directoryPath;
  EditReceiptScreenModel editReceiptScreenModel;
  FirebaseUser user;
  // User get user => _user;
  bool get alsoReceivePromosThruEmail => _alsoReceivePromosThruEmail;
  Period get viewing_period => _viewing_period;
  bool get receiveUniquePromos => _receiveUniquePromos;
  bool get receiveOpenToAllPromos => _receiveOpenToAllPromos;

  AppModel() {
    init();
  }

  void init() {
    editReceiptScreenModel = EditReceiptScreenModel(this);
    mAuth = FirebaseAuth.instance;
    determineLocalPath();
    print("The path is: ${directoryPath}");
    if (FileSystemEntity.typeSync("$directoryPath/ReceiptsJson") ==
        FileSystemEntityType.notFound) {
      print("not found so created");
      new Directory("$directoryPath/ReceiptsJson/").create(recursive: true);
    } else {
      print('exists');
    }
  }

  Future<FirebaseUser> login(String email, String password) async {
    user = await mAuth.signInWithEmailAndPassword(
        email: email, password: password);
    print("The user is ${user.toString()}");
    init();
// dart
    return user;
  }

  req() async {
    // SimplePermissions s = SimplePermissions();
    // s.erq
    // // requestPer

    // requestPermission(Permission.WriteExternalStorage);
  }

  determineLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();
    directoryPath = directory.path;
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
