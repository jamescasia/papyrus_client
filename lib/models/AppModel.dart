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

enum Period { MONTHLY, WEEKLY, DAILY }

class AppModel extends Model {
  // User _user;
  MethodChannel platform = const MethodChannel('papyrus_client/');
  Period _viewing_period = Period.DAILY;
  bool _alsoReceivePromosThruEmail;
  bool _receiveUniquePromos;
  bool _receiveOpenToAllPromos;
  List<String> _receipts_json_paths = [];
  List<ReceiptHeader> receiptHeaders= [];
  FirebaseAuth mAuth;
  String platformVersion;
  bool receiptHeadersAreReady = false;
  // String rootFilePath;
  EditReceiptScreenModel editReceiptScreenModel;
  CameraCaptureModel cameraCaptureModel;
  ReceiveReceiptModel receiveReceiptModel;
  ReceiptsScreenModel receiptsScreenModel;

  FirebaseUser user;
  Directory rootDir;
  Directory tempDir;
  List<String> dirList;

  Map<String, String> dirMap = {
    "Receipts": "null",
    "ReceiptsImages": "null", 
    "UserData": "null",
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
    if (user == null) return;
    try {
      platformVersion = await SimplePermissions.platformVersion;
    } catch (e) {
      platformVersion = "failed to get platform version";
    }
    for (Permission p in perms) {
      // perm_results.addEntries(p:null);
      perm_results[p] = await SimplePermissions.requestPermission(p);
    }
    print("The permission results" + perm_results.toString());

    editReceiptScreenModel = EditReceiptScreenModel(this);
    cameraCaptureModel = CameraCaptureModel(this);
    receiveReceiptModel = ReceiveReceiptModel(this);
    receiptsScreenModel = ReceiptsScreenModel(this);
    rootDir = await getApplicationDocumentsDirectory();
    await checkOrGenerateDirectories();
    listFileNamesOfReceiptsFoundInStorage();
     generateReceiptHeaders();


    tempDir = await getTemporaryDirectory();
    generateImage();
  }

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
    _receipts_json_paths.add(path);

    var rh = new ReceiptHeader(
        r.dateTime, r.merchant, r.total, r.items[0].name, null);
    receiptHeaders.add(rh);

    // notifyListeners();
  }

  void listFileNamesOfReceiptsFoundInStorage() {
    List<FileSystemEntity> files;
    print("here are the files");
    files = Directory(dirMap['Receipts'])
        .listSync(recursive: true, followLinks: false);
    for (int i = 0; i < files.length; i++) {
      _receipts_json_paths.add(files[i].path);
      // receiptsScreenModel.rec
      // print(files[i].path);
    }
  }

    generateReceiptHeaders() async {
    for (String rpath in _receipts_json_paths) {
      File rJSON = File(rpath);
      Map map = jsonDecode(await rJSON.readAsString());
      Receipt r = new Receipt.fromJson(map);
      var rh = new ReceiptHeader(
          r.dateTime, r.merchant, r.total, r.items[0].name, null);
      receiptHeaders.add(rh); 
    }
    receiptHeadersAreReady =  true;

    print("DONE LOOOADIINNNNGG");
    print(receiptHeaders.length);
    notifyListeners();
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

class ReceiptHeader {
  String date;
  String merchant;
  double total;
  String firstItemName;
  String imagePath;
  ReceiptHeader(
      this.date, this.merchant, this.total, this.firstItemName, this.imagePath);
}
