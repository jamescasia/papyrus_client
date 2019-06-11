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
enum Period { MONTHLY, WEEKLY, DAILY }

class AppModel extends Model {
  // User _user;
  MethodChannel platform = const MethodChannel('papyrus_client/');
  Period _viewing_period = Period.DAILY;
  bool _alsoReceivePromosThruEmail;
  bool _receiveUniquePromos;
  bool _receiveOpenToAllPromos;
  List<String> _receipts_json_paths;
  FirebaseAuth mAuth;
  String platformVersion;
  // String rootFilePath;
  EditReceiptScreenModel editReceiptScreenModel;
  CameraCaptureModel cameraCaptureModel;
  ReceiveReceiptModel receiveReceiptModel; 
  FirebaseUser user;
  Directory rootDir;
  Directory tempDir;
  List<String> dirList = ["/ReceiptsJson", "/ReceiptsImages", "/UserData"];
  String userQRPath;
  List <Permission> perms = [Permission.AccessCoarseLocation, Permission.AccessFineLocation,Permission.Camera, Permission.ReadExternalStorage, Permission.WriteExternalStorage];
  Map <Permission, PermissionStatus> perm_results = new Map<Permission, PermissionStatus>();
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
    
    try{
      platformVersion = await SimplePermissions.platformVersion;
    }
    catch(e){
      platformVersion = "failed to get platform version";
    }
    for(Permission p in perms){
      // perm_results.addEntries(p:null);
      perm_results[p] = await SimplePermissions.requestPermission(p);
    }
      print("The permission results" + perm_results.toString());





    editReceiptScreenModel = EditReceiptScreenModel(this);
    cameraCaptureModel = CameraCaptureModel(this);
    receiveReceiptModel = ReceiveReceiptModel(this);
    rootDir = await getApplicationDocumentsDirectory(); 
    tempDir = await getTemporaryDirectory();
    print("THE ROOT DERR" + rootDir.path);
    checkOrGenerateDirectories();
    generateImage();

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


    List<FileSystemEntity> files ;
    print("here are the files");
    files = rootDir.listSync(recursive: true, followLinks: false);
    for(int i = 0 ; i< files.length; i++){

      // print(files[i].path);
    }
     
    // print("the size of files is" + files.length.toString());
    
  }



  void generateImage() async {
   try {
      var imageFile = await EfQrcode.generate(user.email, "#ffffff", "#000000"); 
      userQRPath =  "${rootDir.path}/UserData/${user.email}.jpg";
      imageFile.copy(userQRPath);
      print('done file');
      // imageFile.pat
    // await imageFile.rename( userQRPath);
    //  file.writeAsBytes(imageFile);

   }
   catch (e) {
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
