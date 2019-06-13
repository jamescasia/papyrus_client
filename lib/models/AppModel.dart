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
import 'package:ef_qrcode/ef_qrcode.dart';
import 'ReceiveReceiptModel.dart';
import 'ReceiptsScreenModel.dart';
import 'package:papyrus_client/data_models/Receipt.dart';
import 'dart:convert';
import 'package:papyrus_client/data_models/UserExpense.dart';

class AppModel extends Model {
  // User _user;
  MethodChannel platform = const MethodChannel('papyrus_client/');
  Period _viewing_period = Period.DAILY;
  bool _alsoReceivePromosThruEmail;
  bool _receiveUniquePromos;
  bool _receiveOpenToAllPromos;
  FirebaseAuth mAuth;
  String platformVersion;
  // String rootFilePath;
  EditReceiptScreenModel editReceiptScreenModel;
  CameraCaptureModel cameraCaptureModel;
  ReceiveReceiptModel receiveReceiptModel;
  ReceiptsScreenModel receiptsScreenModel;
  FirebaseUser user;
  Directory rootDir;
  Directory tempDir;
  List<String> dirList;

  List<FileSystemEntity> receiptFiles;
  List<FileSystemEntity> expenseFiles;
  Map<String, String> dirMap = {
    "Receipts": "null",
    "ReceiptsImages": "null",
    "UserData": "null",
    "Expenses": "null",
  };
  String userQRPath;
  List<Permission> perms = [
    Permission.AccessCoarseLocation,
    Permission.AccessFineLocation,
    Permission.Camera,
    Permission.ReadExternalStorage,
    Permission.WriteExternalStorage
  ];
  Map<Permission, PermissionStatus> perm_results =
      new Map<Permission, PermissionStatus>();
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
    // if (user == null) return;
    // try {
    //   platformVersion = await SimplePermissions.platformVersion;
    // } catch (e) {
    //   platformVersion = "failed to get platform version";
    // }
    // for (Permission p in perms) {
    //   // perm_results.addEntries(p:null);
    //   perm_results[p] = await SimplePermissions.requestPermission(p);
    // }
    // print("The permission results" + perm_results.toString());

    editReceiptScreenModel = EditReceiptScreenModel(this);
    cameraCaptureModel = CameraCaptureModel(this);
    receiveReceiptModel = ReceiveReceiptModel(this);
    receiptsScreenModel = ReceiptsScreenModel(this);
    rootDir = await getApplicationDocumentsDirectory();
    await checkOrGenerateDirectories();
    // await deleteAllReceiptFiles();
    listFileNamesOfReceiptsFoundInStorageAndGenerateReceipts();

    tempDir = await getTemporaryDirectory();
    generateImage();
  }

  void deleteAllReceiptFiles() async {
    List<FileSystemEntity> files;
    print("here are the files");
    files = Directory(dirMap['Receipts'])
        .listSync(recursive: true, followLinks: false);
    for (int i = 0; i < files.length; i++) {
      File rJSON = File(files[i].path);
      await rJSON.delete();

      print('ouyst');
    }
  }
/**
 * Process
 * 
 * 
 * 
 * 
 */



// void saveReceiptToJsonAndToFile() {
//     print("locals" + appModel.rootDir.path);
//     print("saving");

//     File file = new File(
//         '${appModel.dirMap['Receipts']}/${_receipt.time_stamp}.json');
//     file.writeAsString(jsonEncode(_receipt.toJson()));

//     readReceiptFromJsonFile(file.path);
//   }

  void addReceiptandSaveToStorage(Receipt r) {
    String path = '${dirMap['Receipts']}/${r.time_stamp}.json';
    File file = new File(path);
    file.writeAsString(jsonEncode(r.toJson()));
    print("The encodedd is tadaa" + jsonEncode(r.toJson()));

    receiptFiles.insert(0, file);
    // _receipts_json_paths.add(path);
    // receipts.insert(0, r);
    // receipts.add(r);

    notifyListeners();
  }

  // void addExpenseAndSaveToStorage(String path){
  //   File file = new File(path);
  //   file.writeAsString(jsonEncode(object)) 
  // }

  void listFileNamesOfReceiptsFoundInStorageAndGenerateReceipts() {
    print("here are the files");
    receiptFiles = Directory(dirMap['Receipts'])
        .listSync(recursive: true, followLinks: false);

    receiptFiles = receiptFiles.reversed.toList();
    notifyListeners();
  }

  void listFileNamesOfExpenseJsonsFoundInStorageAndGenerateExpenses() {
    expenseFiles = Directory(dirMap['Expenses'])
        .listSync(recursive: true, followLinks: false);
  }

  checkOrGenerateDirectories() async {
    for (String i in dirMap.keys) {
      String path = await Directory("${rootDir.path}/${user.uid}/${i}/")
          .create(recursive: true)
          .then((dir) {
        return dir.path;
      });
      dirMap[i] = path;
    }
    return true;
  }

  void findAllReceipts() async {}

  void generateImage() async {
    try {
      var imageFile = await EfQrcode.generate(user.email, "#ffffff", "#000000");
      userQRPath = "${dirMap['UserData']}/${user.email}.jpg";
      imageFile.copy(userQRPath);
      print('done file');
      // imageFile.pat
      // await imageFile.rename( userQRPath);
      //  file.writeAsBytes(imageFile);

    } catch (e) {
      print(e);
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

class UserPreferences {
  bool receiveUniquePromos;
  bool receiveOpenToAllPromos;

  // String

}
