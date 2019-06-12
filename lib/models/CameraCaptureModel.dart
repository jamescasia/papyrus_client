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
  String ssid = "";
  String passkey = "";
  String ip = "";

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

  void stopCapturingFrames() {
    cameraScreenState.controller.stopImageStream();
  }

  Future<bool> captureQRPhoto() async {
    String tempImagePath =
        "${appModel.tempDir.path}/${DateTime.now().millisecondsSinceEpoch.toString()}.png";
    try {
      await cameraScreenState.controller.takePicture(tempImagePath);
      return scanQRCode(tempImagePath);
    } catch (a) {
      print("failed");
      print(a.toString());
      return false;
      // return false;
    }
  }

  Future<bool> scanQRCode(String imagePath) async {
    bool foundQR = false;
    FirebaseVisionBarcodeDetector barcodeDetector =
        FirebaseVisionBarcodeDetector.instance;

        // barcodeDetector.
    try {
      List<VisionBarcode> barcodes =
          await barcodeDetector.detectFromPath(imagePath);

      String rawValueCreds;
      for (VisionBarcode b in barcodes) {
// "PapyrusWifi:ssid:passkey"
        if ((b.rawValue).contains("papyrus")||(b.rawValue).contains("Papyrus")||(b.rawValue).contains("Wifi")) {
          foundQR = true;
          rawValueCreds = b.rawValue;
          print("The raw value :o $rawValueCreds");
          var creds = parseWifiCreds(rawValueCreds);
          ssid = creds[0];
          passkey = creds[1];
          ip = creds[2];
          // connectToWifi(creds[0], creds[1]);

         File(imagePath)?.delete();
          print("returned  true");
          return true;
          // break;

        }
      }
      print("nNONONONONONONo papyrus qr");
      print("returned  false");
      return false;
    } catch (a) {
      print(a.toString());
      print("returned  false");
      return false;
    }

    // if (!foundQR) {
    //   showToastWidget(Text("QR code is unreadable. Please scan again."));
    // }
  }

  List<String> parseWifiCreds(String raw) {

    return raw.split(":").sublist(1);
  }
}
