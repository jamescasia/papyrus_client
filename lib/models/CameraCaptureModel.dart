import 'package:scoped_model/scoped_model.dart';
import 'package:papyrus_client/screens/CameraCaptureScreen.dart';
import 'package:camera/camera.dart';
import 'AppModel.dart';
import 'package:mlkit/mlkit.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart'; 
import 'package:flutter/material.dart';

class CameraScreenState {
  List<CameraDescription> cameras;
  CameraController controller;
  bool controllerInitSuccesful = false;
}

class CameraCaptureModel extends Model {
  CameraScreenState cameraScreenState;

  AppModel appModel;
  String imagePath;
  String wifiSSID;
  String passKey;

  CameraCaptureModel(this.appModel) {
    cameraScreenState = CameraScreenState();
  }

  launch() {
    print('launchinner;');

    cameraScreenState = CameraScreenState();

    getController();
  }

  launchQRScan() async {
    print("did you really launch qr scan?");
    //  startCapturingFrames();
    // String creds = await scanQrCodeWifiCredentials();
    // print("tandanddandan the wifi cred are" + creds);
  }

  capturePhoto() async {
    // imagePath =  "${appModel.rootDir.path}/ReceiptsImages/${DateTime.now().millisecondsSinceEpoch}.png";
    print("take");
    appModel.editReceiptScreenModel.createReceipt();
    try {
      // appModel.editReceiptScreenModel.setCurrentImagePath(imagePath);
      await cameraScreenState.controller
          .takePicture(appModel.editReceiptScreenModel.receipt.imagePath);
      // print(await File(imagePath).readAsString());
      // return true;
    } catch (a) {
      print(a.toString());
      // return false;
    }
  }



  Future<void> connectToWifi(String ssid, String passkey) async {
    try {
      print("WIFI creds be like " + ssid + passkey);
      print('tryn to connect');

      var creds = <String, String> {

        "ssid": ssid,
        "passkey":passkey, 
      };

      await appModel.platform.invokeMethod("initializeConnection", creds);
      print('successful');
    } catch (e) {
      print(e);
    }
  }

  Future<CameraController> getController() async {
    CameraDescription cam;
    cameraScreenState.cameras = await availableCameras();
    // cameraScreenState.controller.
    print("the available cameras");
    for (int i = 0; i < cameraScreenState.cameras.length; i++) {
      print(cameraScreenState.cameras[i].lensDirection);

      if (cameraScreenState.cameras[i].lensDirection ==
          CameraLensDirection.back) {
        cam = cameraScreenState.cameras[i];
        break;
      }
    }

    cameraScreenState.controller = CameraController(cam, ResolutionPreset.high);
    globalController = cameraScreenState.controller;
    try {
      await cameraScreenState.controller.initialize();
      cameraScreenState.controllerInitSuccesful = true;

      return cameraScreenState.controller;
    } catch (a) {
      cameraScreenState.controllerInitSuccesful = false;

      return cameraScreenState.controller;
    }
  }

  // Future<String> scanQrCodeWifiCredentials() async {
  //   String creds = await new QRCodeReader()
  //       .setAutoFocusIntervalInMs(200) // default 5000
  //       .setForceAutoFocus(true) // default false
  //       .setTorchEnabled(true) // default false
  //       .setHandlePermissions(true) // default true
  //       .setExecuteAfterPermissionGranted(true) // default true
  //       .scan();

  //   return creds;
  // }
  void stopCapturingFrames(){

    cameraScreenState.controller.stopImageStream();
  }
  // void startCapturingFrames() async {
  //   await cameraScreenState.controller.startImageStream((frame) {

  //     print("capturing a frame like an idiot!");
  //     print("The frame details are: " + frame.height.toString() + " " + frame.width.toString() + "Format: " + frame.format.group.toString());
  //      scanQRCode(frame);
  //   });
  // }

   captureQRPhoto() async { 
     String tempImagePath =  "${appModel.tempDir.path}/${DateTime.now().millisecondsSinceEpoch.toString()}.png" ;
    try { 
      await cameraScreenState.controller
          .takePicture(  tempImagePath ).then((_){
            scanQRCode(tempImagePath); 
          });
        
      // print(await File(imagePath).readAsString());
      // return true;
    } catch (a) {
      print("failed");
      print(a.toString());
      // return false;
    }

  }

  void scanQRCode(String imagePath) async {

    FirebaseVisionBarcodeDetector barcodeDetector = FirebaseVisionBarcodeDetector.instance;
    List <VisionBarcode> barcodes = await barcodeDetector.detectFromPath(imagePath); 
    String rawValueCreds;
    for(VisionBarcode b in barcodes){
// "PapyrusWifi:ssid:passkey"
      if(  (b.rawValue).contains("PapyrusWifi")){
        rawValueCreds =b.rawValue;
        break;
      }


    }
    print("The raw value :o $rawValueCreds");
    var creds = parseWifiCreds(rawValueCreds);
    connectToWifi(creds[0], creds[1]);
    
    await File(imagePath)?.delete();

    
  
  }

  List<String> parseWifiCreds(String raw){
 
    wifiSSID = raw;
    passKey = raw;

    return raw.split(":").sublist(1);
  } 
}
